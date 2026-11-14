package com.teacode.catalog;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import com.teacode.config.AppProperties;
import com.teacode.exception.BadRequestException;
import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import org.junit.jupiter.api.Test;

/** Parsing and safety checks only (no database). Storage and history are covered by the integration tests. */
class ProblemPackageImporterTest {

    static ProblemPackageImporter importer(long maxExpanded, long maxFile, int maxEntries) {
        AppProperties props = new AppProperties("http://localhost", "",
                new AppProperties.Security("x".repeat(40), "t", 15, 14, false),
                new AppProperties.Jdoodle("", "", "http://x", 1, 1, 1, 20, 60, ""),
                new AppProperties.Imports(20_000_000, maxExpanded, maxFile, maxEntries, "", true), null);
        return new ProblemPackageImporter(null, null, props);
    }

    static byte[] zip(Map<String, String> files) throws Exception {
        ByteArrayOutputStream bytes = new ByteArrayOutputStream();
        try (ZipOutputStream z = new ZipOutputStream(bytes)) {
            for (var e : files.entrySet()) {
                z.putNextEntry(new ZipEntry(e.getKey()));
                z.write(e.getValue().getBytes(StandardCharsets.UTF_8));
                z.closeEntry();
            }
        }
        return bytes.toByteArray();
    }

    static Map<String, String> valid() {
        Map<String, String> f = new LinkedHashMap<>();
        f.put("problem.yaml", "name: Sum of two\nuuid: abc-123\nlimits:\n  time_limit: 1.5\n  memory: 128\nsource: Example Contest\nlicense: cc by-sa\n");
        f.put("problem_statement/problem.en.md", "Add two numbers.");
        f.put("data/sample/1.in", "1 2\n");
        f.put("data/sample/1.ans", "3\n");
        f.put("data/secret/a.in", "5 6\n");
        f.put("data/secret/a.ans", "11\n");
        f.put("data/secret/b.in", "7 8\n");
        f.put("data/secret/b.ans", "15\n");
        return f;
    }

    @Test
    void parsesAValidPackage() throws Exception {
        var p = importer(1_000_000, 100_000, 50).parse(zip(valid()), "h".repeat(64));
        assertThat(p.name()).isEqualTo("Sum of two");
        assertThat(p.timeLimitSeconds()).isEqualTo(1.5);
        assertThat(p.memoryLimitKb()).isEqualTo(128 * 1024);
        assertThat(p.samples()).hasSize(1);
        assertThat(p.secrets()).hasSize(2);
        assertThat(p.stableId()).isEqualTo("uuid:abc-123");
        assertThat(p.attribution()).contains("Example Contest").contains("cc by-sa");
    }

    @Test
    void rejectsPathTraversalAndAbsolutePaths() throws Exception {
        for (String bad : new String[] {"../evil.in", "data/../../evil", "/etc/passwd", "data\\x"}) {
            Map<String, String> f = valid();
            f.put(bad, "x");
            assertThatThrownBy(() -> importer(1_000_000, 100_000, 50).parse(zip(f), "h"))
                    .as(bad).isInstanceOf(BadRequestException.class);
        }
    }

    @Test
    void rejectsOversizedFilesAndExpansion() throws Exception {
        Map<String, String> big = valid();
        big.put("data/secret/c.in", "x".repeat(5000));
        big.put("data/secret/c.ans", "y");
        assertThatThrownBy(() -> importer(1_000_000, 1000, 50).parse(zip(big), "h")).isInstanceOf(BadRequestException.class);
        assertThatThrownBy(() -> importer(100, 100_000, 50).parse(zip(valid()), "h")).isInstanceOf(BadRequestException.class);
        assertThatThrownBy(() -> importer(1_000_000, 100_000, 3).parse(zip(valid()), "h")).isInstanceOf(BadRequestException.class);
    }

    @Test
    void rejectsUnpairedTestsAndMissingParts() throws Exception {
        Map<String, String> f = valid();
        f.remove("data/secret/b.ans");
        assertThatThrownBy(() -> importer(1_000_000, 100_000, 50).parse(zip(f), "h")).isInstanceOf(BadRequestException.class);

        Map<String, String> noYaml = valid();
        noYaml.remove("problem.yaml");
        assertThatThrownBy(() -> importer(1_000_000, 100_000, 50).parse(zip(noYaml), "h")).isInstanceOf(BadRequestException.class);

        Map<String, String> noStatement = valid();
        noStatement.remove("problem_statement/problem.en.md");
        assertThatThrownBy(() -> importer(1_000_000, 100_000, 50).parse(zip(noStatement), "h")).isInstanceOf(BadRequestException.class);
    }

    @Test
    void rejectsProblemsThatCannotBeJudgedFaithfully() throws Exception {
        Map<String, String> f = valid();
        f.put("problem.yaml", "name: X\nvalidation: custom\n");
        assertThatThrownBy(() -> importer(1_000_000, 100_000, 50).parse(zip(f), "h")).isInstanceOf(BadRequestException.class);
    }

    @Test
    void notAZipIsRejectedWithoutEchoingContent() {
        assertThatThrownBy(() -> importer(1_000_000, 100_000, 50).parse("not a zip".getBytes(StandardCharsets.UTF_8), "h"))
                .isInstanceOf(BadRequestException.class);
    }

    @Test
    void slugsAreSafe() {
        assertThat(ProblemPackageImporter.slugify("A + B: the \"Sum\"!")).isEqualTo("a-b-the-sum");
        assertThat(ProblemPackageImporter.slugify("???")).isEqualTo("problem");
    }
}
