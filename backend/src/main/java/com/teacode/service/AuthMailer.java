package com.teacode.service;

/** Sends the account emails. Implementations must never log links or tokens. */
public interface AuthMailer {

    void sendVerification(String to, String link);

    void sendPasswordReset(String to, String link);
}
