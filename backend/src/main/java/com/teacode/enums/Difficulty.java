package com.teacode.enums;

import java.util.Locale;
import java.util.Optional;

public enum Difficulty {
    EASY, MEDIUM, HARD, UNRATED;

    public static Optional<Difficulty> parse(String value) {
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
