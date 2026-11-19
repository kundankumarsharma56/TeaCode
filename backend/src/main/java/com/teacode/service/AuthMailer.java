package com.teacode.service;

/** Sends the account emails. Implementations must never log links or tokens. */
public interface AuthMailer {

    void sendVerification(String to, String link);

    void sendPasswordReset(String to, String link);

    /**
     * Sends a 6-digit code (purpose VERIFY or RESET). Unlike the link methods this is synchronous and throws
     * MailDeliveryException when the message was not accepted, so the caller never reports success for a lost email.
     */
    void sendOtp(String to, String purpose, String code, int minutes);
}
