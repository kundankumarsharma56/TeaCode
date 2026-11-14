package com.teacode.execution;

import java.util.ArrayList;
import java.util.List;

/** Compares program output with the expected output according to the problem's comparison mode. Pure and side-effect free. */
public final class OutputComparator {

    public static final double DEFAULT_TOLERANCE = 1e-6;

    private OutputComparator() {
    }

    public static boolean matches(String mode, String expected, String actual, Double tolerance) {
        String e = expected == null ? "" : expected;
        String a = actual == null ? "" : actual;
        return switch (mode == null ? "TRIM_LINES" : mode) {
            case "EXACT" -> e.replace("\r\n", "\n").equals(a.replace("\r\n", "\n"));
            case "TOKEN" -> tokens(e).equals(tokens(a));
            case "FLOAT_TOLERANCE" -> floatTokensMatch(tokens(e), tokens(a), tolerance == null ? DEFAULT_TOLERANCE : tolerance);
            default -> trimLines(e).equals(trimLines(a));
        };
    }

    /** Ignores trailing whitespace on each line and trailing blank lines. */
    static List<String> trimLines(String s) {
        List<String> lines = new ArrayList<>();
        for (String line : s.replace("\r\n", "\n").split("\n", -1)) {
            lines.add(line.stripTrailing());
        }
        while (!lines.isEmpty() && lines.get(lines.size() - 1).isEmpty()) {
            lines.remove(lines.size() - 1);
        }
        return lines;
    }

    static List<String> tokens(String s) {
        String t = s.strip();
        return t.isEmpty() ? List.of() : List.of(t.split("\\s+"));
    }

    private static boolean floatTokensMatch(List<String> expected, List<String> actual, double tol) {
        if (expected.size() != actual.size()) {
            return false;
        }
        for (int i = 0; i < expected.size(); i++) {
            String x = expected.get(i);
            String y = actual.get(i);
            if (x.equals(y)) {
                continue;
            }
            Double dx = parse(x);
            Double dy = parse(y);
            if (dx == null || dy == null || dx.isNaN() || dy.isNaN()) {
                return false;
            }
            double diff = Math.abs(dx - dy);
            if (!(diff <= tol || diff <= tol * Math.abs(dx))) {
                return false;
            }
        }
        return true;
    }

    /** Plain decimal or scientific notation only: Double.valueOf would also accept "1.5f", "2d", hex floats and "NaN". */
    private static final java.util.regex.Pattern NUMBER = java.util.regex.Pattern.compile("[+-]?(\\d+\\.?\\d*|\\.\\d+)([eE][+-]?\\d+)?");

    private static Double parse(String s) {
        if (!NUMBER.matcher(s).matches()) {
            return null;
        }
        try {
            return Double.valueOf(s);
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
