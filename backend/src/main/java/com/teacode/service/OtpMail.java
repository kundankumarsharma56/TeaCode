package com.teacode.service;

/** Subject and body of the 6-digit code email. The code is never logged. */
final class OtpMail {

    private OtpMail() {
    }

    static String subject(String purpose) {
        return "RESET".equals(purpose) ? "Reset your TeaCode password" : "Verify your TeaCode email";
    }

    static String text(String purpose, String code, int minutes) {
        String what = "RESET".equals(purpose) ? "reset your password" : "verify your email address";
        return "Your TeaCode code to " + what + " is: " + code + "\n\nIt is valid for " + minutes
                + " minutes. Do not share it with anyone.\n\nIf you did not ask for this, you can ignore this email.";
    }

    /** The code is digits only, so no HTML escaping is needed. */
    static String html(String purpose, String code, int minutes) {
        String what = "RESET".equals(purpose) ? "reset your password" : "verify your email address";
        return "<!DOCTYPE html><html lang=\"en\"><body style=\"margin:0;padding:24px;background:#f2f6f2;font-family:Arial,Helvetica,sans-serif;color:#202020;\">"
                + "<div style=\"max-width:480px;margin:0 auto;background:#ffffff;border:1px solid #dfe8e1;border-radius:10px;padding:28px;\">"
                + "<div style=\"font-size:24px;font-weight:700;color:#16852b;margin-bottom:12px;\">TeaCode</div>"
                + "<p style=\"font-size:16px;line-height:1.5;margin:0 0 16px;\">Use this code to " + what + ":</p>"
                + "<p style=\"font-size:34px;font-weight:700;letter-spacing:8px;margin:0 0 16px;\">" + code + "</p>"
                + "<p style=\"font-size:14px;line-height:1.5;color:#3b463f;margin:0 0 8px;\">It is valid for " + minutes + " minutes. Do not share it with anyone.</p>"
                + "<p style=\"font-size:12px;line-height:1.5;color:#6b7a70;margin:0;\">If you did not ask for this, you can ignore this email.</p>"
                + "</div></body></html>";
    }
}