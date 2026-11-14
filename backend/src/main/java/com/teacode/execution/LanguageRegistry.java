package com.teacode.execution;

import com.teacode.config.AppProperties;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import org.springframework.stereotype.Component;

/**
 * The languages offered to users, with the JDoodle identifiers used to run them.
 *
 * <p>Identifiers and version indexes come from the JDoodle language reference
 * (https://www.jdoodle.com/docs/api/languages, checked October 2026). A {@code versionIndex} is a position in
 * JDoodle's list for that language, not a version number, and JDoodle can change its list: re-check the page
 * before changing a value. Keys are our own stable names (existing submissions store them).
 *
 * <p>Whether a language really runs depends on the JDoodle plan and on JDoodle itself; that cannot be known
 * without calling it (each call costs a credit), so operators can switch a language off with
 * {@code JDOODLE_DISABLED_LANGUAGES}. Nothing is offered while credentials are missing.
 */
@Component
public class LanguageRegistry {

    /** PROGRAM: full programs on stdin/stdout. DATABASE: SQL; only for the free-form compiler, never for judging. */
    public enum Kind { PROGRAM, DATABASE }

    /**
     * @param extension source file extension, with the dot (informational: JDoodle chooses the real file name)
     * @param toolchain compiler or runtime family, for display and documentation
     */
    public record Lang(String key, String name, String version, String jdoodleLanguage, String versionIndex,
                       boolean compiled, Kind kind, String extension, String toolchain) {
        public boolean judgeable() {
            return kind == Kind.PROGRAM;
        }
    }

    private static final List<Lang> ALL = List.of(
            new Lang("java", "Java", "JDK 21.0.0", "java", "5", true, Kind.PROGRAM, ".java", "OpenJDK (javac + java)"),
            new Lang("python", "Python 3", "3.14.3", "python3", "6", false, Kind.PROGRAM, ".py", "CPython"),
            new Lang("c", "C", "GCC 13.2.1", "c", "6", true, Kind.PROGRAM, ".c", "GCC"),
            new Lang("cpp", "C++", "g++ 17, GCC 13.2.1", "cpp17", "2", true, Kind.PROGRAM, ".cpp", "G++ (GCC)"),
            new Lang("javascript", "JavaScript (Node.js)", "Node.js 25.8.1", "nodejs", "7", false, Kind.PROGRAM, ".js", "Node.js"),
            new Lang("typescript", "TypeScript", "5.9.3", "typescript", "1", false, Kind.PROGRAM, ".ts", "TypeScript on Node.js"),
            new Lang("csharp", "C#", ".NET 10.0", "csharp", "6", true, Kind.PROGRAM, ".cs", ".NET SDK"),
            new Lang("php", "PHP", "8.5.4", "php", "6", false, Kind.PROGRAM, ".php", "PHP CLI"),
            new Lang("ruby", "Ruby", "3.4.8", "ruby", "6", false, Kind.PROGRAM, ".rb", "Ruby (MRI)"),
            new Lang("go", "Go", "1.26.1", "go", "6", true, Kind.PROGRAM, ".go", "Go toolchain"),
            new Lang("r", "R", "4.5.3", "r", "6", false, Kind.PROGRAM, ".R", "R (Rscript)"),
            new Lang("kotlin", "Kotlin", "2.3.10", "kotlin", "5", true, Kind.PROGRAM, ".kt", "Kotlin compiler on the JVM"),
            new Lang("rust", "Rust", "1.94.0", "rust", "6", true, Kind.PROGRAM, ".rs", "rustc"),
            new Lang("swift", "Swift", "6.2.4", "swift", "6", true, Kind.PROGRAM, ".swift", "Swift compiler"),
            // Dart: the JDoodle identifier is "dart". The version index 0 is the first entry of JDoodle's list and has NOT
            // been checked against the live list (the reference page was unreachable when this was added): check it,
            // set the real index, and update the version text before relying on a specific Dart version. Marked as not
            // "compiled" so no compile-only call (which may be unsupported for it) is made: compile errors then show as output.
            new Lang("dart", "Dart", "Dart SDK (JDoodle index 0, unchecked)", "dart", "0", false, Kind.PROGRAM, ".dart", "Dart SDK"),
            new Lang("sql", "SQL (MySQL)", "MySQL", "mysql", "0", false, Kind.DATABASE, ".sql", "MySQL"));

    private final boolean configured;
    private final Set<String> disabled;

    public LanguageRegistry(AppProperties props) {
        this.configured = props.jdoodle().configured();
        this.disabled = props.jdoodle().disabledLanguageKeys();
    }

    /** Languages the server will accept. Empty when JDoodle credentials are not configured. */
    public List<Lang> available() {
        if (!configured) {
            return List.of();
        }
        return ALL.stream().filter(l -> !disabled.contains(l.key())).toList();
    }

    /**
     * Languages offered by the interactive Terminal. They run on the isolated Docker runner, so they do not depend on
     * JDoodle credentials. Whether the runner itself is configured is checked by the caller.
     */
    public List<Lang> interactive() {
        return ALL.stream().filter(l -> l.kind() == Kind.PROGRAM).toList();
    }

    public Optional<Lang> findInteractive(String key) {
        return interactive().stream().filter(l -> l.key().equals(key)).findFirst();
    }

    public boolean isConfigured() {
        return configured;
    }

    public Optional<Lang> find(String key) {
        return available().stream().filter(l -> l.key().equals(key)).findFirst();
    }

    /** Languages that can judge problems (everything except the SQL playground). */
    public List<Lang> judgeable() {
        return available().stream().filter(Lang::judgeable).toList();
    }

    /** All known languages regardless of configuration (used by tests and documentation). */
    static List<Lang> known() {
        return ALL;
    }
}
