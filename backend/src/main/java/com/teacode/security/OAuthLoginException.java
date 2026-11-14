package com.teacode.security;

/** A sign-in that must be refused. {@code code} is a short, safe token shown to the user via the login page. */
public class OAuthLoginException extends RuntimeException {

    private final String code;

    public OAuthLoginException(String code) {
        super(code);
        this.code = code;
    }

    public String getCode() {
        return code;
    }
}
