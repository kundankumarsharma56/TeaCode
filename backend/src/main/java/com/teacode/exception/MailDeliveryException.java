package com.teacode.exception;

import org.springframework.http.HttpStatus;

/** The email provider did not accept the message. The caller must not report success. */
public class MailDeliveryException extends ApiException {

    public MailDeliveryException() {
        super(HttpStatus.SERVICE_UNAVAILABLE, "MAIL_FAILED", "Could not send the email. Try again later.");
    }
}