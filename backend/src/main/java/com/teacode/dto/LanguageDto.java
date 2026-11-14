package com.teacode.dto;

/** A language the platform can run right now. {@code version} is null when the exact toolchain version is not known. */
public record LanguageDto(String key, String name, String version, String kind, String extension, String toolchain) {
}
