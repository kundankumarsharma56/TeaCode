package com.teacode.enums;

import java.util.Locale;
import java.util.Optional;

public enum ProblemSort {
    NEWEST, OLDEST, TITLE, DIFFICULTY, RATING_ASC, RATING_DESC;

    public static Optional<ProblemSort> parse(String value) {
        if (value == null) {
            return Optional.empty();
        }
        try {
            return Optional.of(valueOf(value.trim().toUpperCase(Locale.ROOT)));
        } catch (IllegalArgumentException e) {
            return Optional.empty();
        }
    }
}
