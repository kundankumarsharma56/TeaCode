package com.teacode.catalog;

import com.teacode.config.AppProperties;
import com.teacode.exception.BadRequestException;
import com.teacode.exception.ConflictException;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.CharacterCodingException;
import java.nio.charset.CodingErrorAction;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TreeMap;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.support.TransactionTemplate;
import org.yaml.snakeyaml.LoaderOptions;
import org.yaml.snakeyaml.Yaml;
import org.yaml.snakeyaml.constructor.SafeConstructor;

/**
 * Imports an AUTHORIZED problem package in the ICPC/Kattis package layout:
 * <pre>
 *   problem.yaml
 *   problem_statement/problem.en.md   (or problem.md / problem.en.tex / problem.tex, stored as plain text)
 *   data/sample/*.in + *.ans          (visible sample tests)
 *   data/secret/**&#47;*.in + *.ans   (private tests; stored on the server only)
 * </pre>
 * The operator must confirm they are allowed to import the package. Archives are treated as hostile: entry
 * names are checked for traversal, sizes are capped while reading (zip bombs), YAML is parsed with the safe
 * constructor, and anything this judge cannot run correctly (custom validators, interactive or multi-pass
 * problems) is rejected rather than imported half-working. Messages never contain test data.
 */
@Service
public class ProblemPackageImporter {

    private static final Logger log = LoggerFactory.getLogger(ProblemPackageImporter.class);

    public record Imported(long problemId, String slug, int sampleTests, int privateTests) {
    }

    private final NamedParameterJdbcTemplate jdbc;
    private final TransactionTemplate tx;
    private final AppProperties props;

    public ProblemPackageImporter(NamedParameterJdbcTemplate jdbc, TransactionTemplate tx, AppProperties props) {
        this.jdbc = jdbc;
        this.tx = tx;
        this.props = props;
    }

    /** Parsed, validated package contents. */
    record Parsed(String name, String statement, String statementFormat, double timeLimitSeconds, int memoryLimitKb,
                  String comparisonMode, Double tolerance, String stableId, String attribution,
                  List<String[]> samples, List<String[]> secrets) {
    }

    public Imported importPackage(byte[] archive, String filename, boolean publish, String licenseNote) {
        if (archive.length == 0 || archive.length > props.imports().maxArchiveBytes()) {
            throw new BadRequestException("The package is empty or larger than the allowed size.");
        }
        String hash = sha256(archive);
        Integer already = jdbc.queryForObject("SELECT COUNT(*) FROM problem_imports WHERE archive_sha256 = :h AND status = 'IMPORTED'",
                new MapSqlParameterSource("h", hash), Integer.class);
        if (already != null && already > 0) {
            throw new ConflictException("This package has already been imported.");
        }
        Parsed parsed;
        try {
            parsed = parse(archive, hash);
        } catch (BadRequestException e) {
            recordFailure(hash, filename, licenseNote, e.getMessage());
            throw e;
        }
        try {
            Imported result = tx.execute(status -> store(parsed, hash, filename, publish, licenseNote));
            return result;
        } catch (org.springframework.dao.DuplicateKeyException e) {
            recordFailure(hash, filename, licenseNote, "A problem with this package id or slug already exists.");
            throw new ConflictException("A problem from this package already exists.");
        }
    }

    // ---------------------------------------------------------------- parsing

    Parsed parse(byte[] archive, String hash) {
        Map<String, byte[]> files = readArchive(archive);
        byte[] yamlBytes = files.get("problem.yaml");
        if (yamlBytes == null) {
            throw new BadRequestException("The package has no problem.yaml.");
        }
        Map<String, Object> yaml = readYaml(yamlBytes);

        String name = nameOf(yaml.get("name"));
        if (name == null || name.isBlank()) {
            throw new BadRequestException("problem.yaml has no usable problem name.");
        }
        Object validation = yaml.get("validation");
        String validationText = validation == null ? "default" : validation.toString().toLowerCase(Locale.ROOT);
        if (validationText.contains("custom") || validationText.contains("interactive") || validationText.contains("multi-pass")
                || validationText.contains("submit-answer")) {
            throw new BadRequestException("Custom, interactive and multi-pass problems cannot be judged here.");
        }
        String comparison = "TOKEN"; // the package standard "default" validator compares whitespace-separated tokens
        Double tolerance = null;
        Object flags = yaml.get("validator_flags");
        if (flags != null && flags.toString().contains("float_tolerance")) {
            comparison = "FLOAT_TOLERANCE";
            tolerance = parseTolerance(flags.toString());
        }

        double time = 2.0;
        int memoryKb = 262144;
        if (yaml.get("limits") instanceof Map<?, ?> limits) {
            Object t = limits.get("time_limit") != null ? limits.get("time_limit") : limits.get("time");
            if (t instanceof Number n && n.doubleValue() > 0 && n.doubleValue() <= 60) {
                time = n.doubleValue();
            }
            if (limits.get("memory") instanceof Number m && m.intValue() > 0 && m.intValue() <= 4096) {
                memoryKb = m.intValue() * 1024; // package memory limits are in MiB
            }
        }

        String statement = null;
        String format = null;
        for (String candidate : List.of("problem_statement/problem.en.md", "problem_statement/problem.md",
                "problem_statement/problem.en.tex", "problem_statement/problem.tex")) {
            if (files.containsKey(candidate)) {
                statement = decode(files.get(candidate), candidate);
                format = candidate.endsWith(".md") ? "MARKDOWN" : "TEX";
                break;
            }
        }
        if (statement == null || statement.isBlank()) {
            throw new BadRequestException("The package has no supported statement (problem.en.md or problem.en.tex).");
        }

        List<String[]> samples = collectTests(files, "data/sample/");
        List<String[]> secrets = collectTests(files, "data/secret/");
        if (samples.isEmpty() && secrets.isEmpty()) {
            throw new BadRequestException("The package contains no test data.");
        }

        Object uuid = yaml.get("uuid");
        String stableId = uuid != null && !uuid.toString().isBlank() ? "uuid:" + uuid.toString().trim() : "sha256:" + hash;
        StringBuilder attribution = new StringBuilder();
        for (String key : List.of("source", "author", "license", "rights_owner")) {
            Object v = yaml.get(key);
            if (v != null && !v.toString().isBlank()) {
                attribution.append(attribution.length() == 0 ? "" : " | ")
                        .append(key.replace('_', ' ')).append(": ").append(truncate(v.toString().trim(), 120));
            }
        }
        return new Parsed(truncate(name, 200), statement, format, time, memoryKb, comparison, tolerance, truncate(stableId, 60),
                attribution.toString(), samples, secrets);
    }

    private Map<String, byte[]> readArchive(byte[] archive) {
        Map<String, byte[]> keep = new LinkedHashMap<>();
        long expanded = 0;
        int entries = 0;
        try (ZipInputStream zip = new ZipInputStream(new ByteArrayInputStream(archive), StandardCharsets.UTF_8)) {
            ZipEntry e;
            while ((e = zip.getNextEntry()) != null) {
                if (++entries > props.imports().maxEntries()) {
                    throw new BadRequestException("The package has too many files.");
                }
                String name = safeName(e.getName());
                if (e.isDirectory()) {
                    continue;
                }
                byte[] data = readBounded(zip, props.imports().maxFileBytes());
                expanded += data.length;
                if (expanded > props.imports().maxExpandedBytes()) {
                    throw new BadRequestException("The package expands to more than the allowed size.");
                }
                if (isWanted(name)) {
                    keep.put(name, data);
                }
            }
        } catch (IOException | IllegalArgumentException e) {
            throw new BadRequestException("The package is not a valid ZIP archive.");
        }
        return keep;
    }

    static String safeName(String raw) {
        if (raw == null || raw.isEmpty() || raw.indexOf('\0') >= 0 || raw.contains("\\") || raw.startsWith("/")
                || raw.matches("^[A-Za-z]:.*")) {
            throw new BadRequestException("The package contains an invalid file path.");
        }
        for (String part : raw.split("/")) {
            if (part.equals("..")) {
                throw new BadRequestException("The package contains an invalid file path.");
            }
        }
        // Packages are sometimes zipped with one top-level folder; strip it when problem.yaml sits inside.
        return raw;
    }

    private static boolean isWanted(String name) {
        return name.equals("problem.yaml") || name.startsWith("problem_statement/") || name.startsWith("data/sample/")
                || name.startsWith("data/secret/");
    }

    private static byte[] readBounded(InputStream in, long max) throws IOException {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        byte[] buf = new byte[8192];
        long total = 0;
        int n;
        while ((n = in.read(buf)) > 0) {
            total += n;
            if (total > max) {
                throw new BadRequestException("A file in the package is larger than the allowed size.");
            }
            out.write(buf, 0, n);
        }
        return out.toByteArray();
    }

    @SuppressWarnings("unchecked")
    private Map<String, Object> readYaml(byte[] bytes) {
        try {
            LoaderOptions options = new LoaderOptions();
            options.setMaxAliasesForCollections(10);
            options.setAllowDuplicateKeys(false);
            Object o = new Yaml(new SafeConstructor(options)).load(new String(bytes, StandardCharsets.UTF_8));
            if (o instanceof Map<?, ?> m) {
                return (Map<String, Object>) m;
            }
        } catch (RuntimeException e) {
            // fall through to the same message; the YAML text is not echoed
        }
        throw new BadRequestException("problem.yaml could not be read.");
    }

    private static String nameOf(Object n) {
        if (n instanceof String s) {
            return s;
        }
        if (n instanceof Map<?, ?> m) {
            Object en = m.get("en");
            if (en != null) {
                return en.toString();
            }
            return m.values().stream().findFirst().map(Object::toString).orElse(null);
        }
        return null;
    }

    private static Double parseTolerance(String flags) {
        java.util.regex.Matcher m = java.util.regex.Pattern.compile("float_tolerance\\s+([0-9.eE+-]+)").matcher(flags);
        if (m.find()) {
            try {
                double d = Double.parseDouble(m.group(1));
                if (d > 0 && d < 1) {
                    return d;
                }
            } catch (NumberFormatException ignored) {
                // use the default
            }
        }
        return null;
    }

    /** Pairs {@code x.in} with {@code x.ans}. Any unpaired file rejects the package. */
    private List<String[]> collectTests(Map<String, byte[]> files, String prefix) {
        TreeMap<String, byte[]> ins = new TreeMap<>(Comparator.comparing(ProblemPackageImporter::naturalKey));
        Map<String, byte[]> answers = new LinkedHashMap<>();
        for (Map.Entry<String, byte[]> e : files.entrySet()) {
            String n = e.getKey();
            if (!n.startsWith(prefix)) {
                continue;
            }
            if (n.endsWith(".in")) {
                ins.put(n.substring(0, n.length() - 3), e.getValue());
            } else if (n.endsWith(".ans")) {
                answers.put(n.substring(0, n.length() - 4), e.getValue());
            }
        }
        if (!ins.keySet().equals(answers.keySet())) {
            throw new BadRequestException("Every test input needs a matching .ans file (and the reverse) under " + prefix + ".");
        }
        List<String[]> out = new ArrayList<>();
        for (Map.Entry<String, byte[]> e : ins.entrySet()) {
            out.add(new String[]{decode(e.getValue(), "test input"), decode(answers.get(e.getKey()), "test answer")});
        }
        return out;
    }

    private static String naturalKey(String s) {
        // zero-pad digit runs so 2 sorts before 10
        StringBuilder out = new StringBuilder();
        java.util.regex.Matcher m = java.util.regex.Pattern.compile("\\d+|\\D+").matcher(s);
        while (m.find()) {
            String g = m.group();
            out.append(Character.isDigit(g.charAt(0)) ? String.format("%010d", Long.parseLong(g.length() > 9 ? g.substring(0, 9) : g)) : g);
        }
        return out.toString();
    }

    private static String decode(byte[] bytes, String what) {
        try {
            String s = StandardCharsets.UTF_8.newDecoder().onMalformedInput(CodingErrorAction.REPORT)
                    .onUnmappableCharacter(CodingErrorAction.REPORT).decode(java.nio.ByteBuffer.wrap(bytes)).toString();
            if (s.indexOf('\0') >= 0) {
                throw new BadRequestException("A package file contains binary data.");
            }
            return s;
        } catch (CharacterCodingException e) {
            throw new BadRequestException("A package file is not valid UTF-8 text.");
        }
    }

    // ---------------------------------------------------------------- storage

    private Imported store(Parsed p, String hash, String filename, boolean publish, String licenseNote) {
        String slug = slugify(p.name()) + "-" + hash.substring(0, 6);
        String description = p.statement() + (p.attribution().isEmpty() ? "" : "\n\n---\nPackage " + p.attribution());
        GeneratedKeyHolder keys = new GeneratedKeyHolder();
        jdbc.update("""
                INSERT INTO problems (title, slug, description, difficulty, comparison_mode, float_tolerance, time_limit_seconds,
                       memory_limit_kb, visibility, source, source_id, statement_status, execution_model, source_synced_at)
                VALUES (:title, :slug, :description, 'UNRATED', :mode, :tol, :time, :mem, :vis, 'PACKAGE', :sid, 'AVAILABLE',
                       'STDIN', UTC_TIMESTAMP(6))""",
                new MapSqlParameterSource().addValue("title", p.name()).addValue("slug", slug).addValue("description", description)
                        .addValue("mode", p.comparisonMode()).addValue("tol", p.tolerance()).addValue("time", p.timeLimitSeconds())
                        .addValue("mem", p.memoryLimitKb()).addValue("vis", publish ? "PUBLISHED" : "DRAFT").addValue("sid", p.stableId()),
                keys);
        long problemId = keys.getKey().longValue();
        int order = 0;
        for (String[] t : p.samples()) {
            insertTest(problemId, t, true, order++);
        }
        for (String[] t : p.secrets()) {
            insertTest(problemId, t, false, order++);
        }
        jdbc.update("""
                INSERT INTO problem_imports (archive_sha256, filename, status, problem_id, license_note)
                VALUES (:h, :f, 'IMPORTED', :pid, :note)""",
                new MapSqlParameterSource().addValue("h", hash).addValue("f", truncate(safeFilename(filename), 200)).addValue("pid", problemId)
                        .addValue("note", truncate(licenseNote, 300)));
        log.info("Imported problem package as problem {} ({} samples, {} private tests)", problemId, p.samples().size(), p.secrets().size());
        return new Imported(problemId, slug, p.samples().size(), p.secrets().size());
    }

    private void insertTest(long problemId, String[] t, boolean sample, int order) {
        jdbc.update("INSERT INTO test_cases (problem_id, input_data, expected_output, sample_case, sort_order) VALUES (:p, :i, :o, :s, :ord)",
                new MapSqlParameterSource().addValue("p", problemId).addValue("i", t[0]).addValue("o", t[1])
                        .addValue("s", sample).addValue("ord", order));
    }

    private void recordFailure(String hash, String filename, String licenseNote, String message) {
        try {
            jdbc.update("""
                    INSERT INTO problem_imports (archive_sha256, filename, status, license_note, error_message)
                    VALUES (:h, :f, 'FAILED', :note, :msg)""",
                    new MapSqlParameterSource().addValue("h", hash).addValue("f", truncate(safeFilename(filename), 200))
                            .addValue("note", truncate(licenseNote, 300))
                            .addValue("msg", truncate(message, 500)));
        } catch (RuntimeException e) {
            log.warn("Could not record the failed import: {}", e.getClass().getSimpleName());
        }
    }

    static String sha256(byte[] data) {
        try {
            return java.util.HexFormat.of().formatHex(java.security.MessageDigest.getInstance("SHA-256").digest(data));
        } catch (java.security.NoSuchAlgorithmException e) {
            throw new IllegalStateException(e);
        }
    }

    static String slugify(String name) {
        String s = name.toLowerCase(Locale.ROOT).replaceAll("[^a-z0-9]+", "-").replaceAll("^-+|-+$", "");
        return s.isEmpty() ? "problem" : truncate(s, 120);
    }

    private static String safeFilename(String f) {
        if (f == null) {
            return "package.zip";
        }
        String base = f.replace('\\', '/');
        return base.substring(base.lastIndexOf('/') + 1).replaceAll("[^A-Za-z0-9._ -]", "_");
    }

    private static String truncate(String s, int max) {
        if (s == null) {
            return null;
        }
        return s.length() <= max ? s : s.substring(0, max);
    }
}
