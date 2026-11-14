package com.teacode.exception;

import org.springframework.http.HttpStatus;

public class TooManyRequestsException extends ApiException {

    public TooManyRequestsException() {
        super(HttpStatus.TOO_MANY_REQUESTS, "RATE_LIMITED", "Too many requests. Please wait a moment and try again.");
    }
}
