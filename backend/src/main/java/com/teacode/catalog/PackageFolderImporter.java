package com.teacode.catalog;

import com.teacode.config.AppProperties;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.LinkOption;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.stream.Stream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * Admin-free package import: ZIPs placed in {@code teacode.imports.folder} on the server are validated and imported
 * automatically on startup and every few minutes. Placing a file there is the operator's statement that they are
 * authorized to use it. A package is processed once (by SHA-256): already-imported and already-failed archives are
 * skipped, so a bad file is reported once in {@code problem_imports} and not retried forever. Disabled when the
 * folder setting is empty. Symlinks and non-regular files are ignored.
 */
@Component
public class PackageFolderImporter {

    private static final Logger log = LoggerFactory.getLogger(PackageFolderImporter.class);

    private final ProblemPackageImporter importer;
    private final NamedParameterJdbcTemplate jdbc;
    private final AppProperties props;
    private final AtomicBoolean running = new AtomicBoolean(false);

    public PackageFolderImporter(ProblemPackageImporter importer, NamedParameterJdbcTemplate jdbc, AppProperties props) {
        this.importer = importer;
        this.jdbc = jdbc;
        this.props = props;
    }

    @EventListener(ApplicationReadyEvent.class)
    public void onStart() {
        scan();
    }

    @Scheduled(fixedDelayString = "${teacode.imports.scan-interval-ms:300000}", initialDelayString = "${teacode.imports.scan-interval-ms:300000}")
    public void scheduled() {
        scan();
    }

    /** Returns the number of packages imported in this pass. Never throws. */
    public int scan() {
        String folder = props.imports().folder();
        if (folder == null || folder.isBlank() || !running.compareAndSet(false, true)) {
            return 0;
        }
        int imported = 0;
        try {
            Path dir = Paths.get(folder);
            if (!Files.isDirectory(dir)) {
                log.warn("Package import folder does not exist: {}", dir);
                return 0;
            }
            List<Path> zips;
            try (Stream<Path> s = Files.list(dir)) {
                zips = s.filter(f -> f.getFileName().toString().toLowerCase().endsWith(".zip"))
                        .filter(f -> Files.isRegularFile(f, LinkOption.NOFOLLOW_LINKS))
                        .sorted().toList();
            }
            for (Path zip : zips) {
                if (importOne(zip)) {
                    imported++;
                }
            }
        } catch (IOException | RuntimeException e) {
            log.warn("Package folder scan failed ({})", e.getClass().getSimpleName());
        } finally {
            running.set(false);
        }
        return imported;
    }

    private boolean importOne(Path zip) {
        try {
            long size = Files.size(zip);
            if (size > props.imports().maxArchiveBytes()) {
                log.warn("Skipping {}: larger than the allowed package size", zip.getFileName());
                return false;
            }
            byte[] bytes = Files.readAllBytes(zip);
            String hash = ProblemPackageImporter.sha256(bytes);
            Integer seen = jdbc.queryForObject("SELECT COUNT(*) FROM problem_imports WHERE archive_sha256 = :h",
                    new MapSqlParameterSource("h", hash), Integer.class);
            if (seen != null && seen > 0) {
                return false; // imported before, or failed before and unchanged
            }
            importer.importPackage(bytes, zip.getFileName().toString(), props.imports().autoPublish(),
                    "Placed in the server import folder by the operator");
            return true;
        } catch (IOException e) {
            log.warn("Could not read package {}", zip.getFileName());
        } catch (RuntimeException e) {
            // Already recorded in problem_imports by the importer; do not echo package content.
            log.warn("Package {} was not imported: {}", zip.getFileName(), e.getMessage());
        }
        return false;
    }
}
