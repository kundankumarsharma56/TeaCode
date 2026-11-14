package com.teacode.service;

import com.teacode.config.AppProperties;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;
import java.time.Year;
import java.util.concurrent.ExecutorService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.web.util.HtmlUtils;

/**
 * Real SMTP delivery, done off the request thread. Each message has a plain-text part and a branded HTML part with the
 * TeaCode logo (embedded in the message, so it shows without any hosted image) and a clickable button. If SMTP is not
 * configured nothing is faked: an error is logged and the email is not sent.
 */
@Component
public class SmtpAuthMailer implements AuthMailer {

    private static final Logger log = LoggerFactory.getLogger(SmtpAuthMailer.class);

    private static final String BRAND_GREEN = "#16852b";
    private static final String LOGO_CID = "teacode-logo";
    private static final ClassPathResource LOGO = new ClassPathResource("email/logo.png");

    private final ObjectProvider<JavaMailSender> senderProvider;
    private final ExecutorService executor;
    private final String host;
    private final String from;

    public SmtpAuthMailer(ObjectProvider<JavaMailSender> senderProvider,
                          @Qualifier("mailExecutor") ExecutorService executor,
                          @Value("${spring.mail.host:}") String host,
                          AppProperties props) {
        this.senderProvider = senderProvider;
        this.executor = executor;
        this.host = host;
        this.from = props.mailFrom();
    }

    @Override
    public void sendVerification(String to, String link) {
        send(to, "Verify your TeaCode email",
                "Welcome to TeaCode.\n\nVerify your email address by opening this link (valid for 24 hours):\n"
                        + link + "\n\nIf you did not create an account, you can ignore this email.",
                "Verify your email address",
                "Welcome to TeaCode. Confirm your email address to finish creating your account and start practising.",
                "Verify email address", link,
                "This link is valid for 24 hours. If you did not create an account, you can safely ignore this email.");
    }

    @Override
    public void sendPasswordReset(String to, String link) {
        send(to, "Reset your TeaCode password",
                "We received a request to reset your TeaCode password.\n\nChoose a new password using this link (valid for 1 hour):\n"
                        + link + "\n\nIf you did not ask for this, you can ignore this email. Your password has not changed.",
                "Reset your password",
                "We received a request to reset your TeaCode password. Choose a new one with the button below.",
                "Choose a new password", link,
                "This link is valid for 1 hour. If you did not ask for this, you can safely ignore this email. Your password has not changed.");
    }

    /** Inline-styled, table-based HTML (what every mail client renders). All text and the link are escaped. */
    private static String html(String heading, String intro, String buttonLabel, String link, String note, boolean logo) {
        String href = HtmlUtils.htmlEscape(link);
        String brand = logo
                ? "<img src=\"cid:" + LOGO_CID + "\" width=\"180\" alt=\"TeaCode\" style=\"display:block;width:180px;max-width:100%;height:auto;border:0;\">"
                : "<span style=\"font-size:28px;font-weight:700;color:" + BRAND_GREEN + ";\">TeaCode</span>";
        return "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\">"
                + "<meta name=\"color-scheme\" content=\"light\"><title>TeaCode</title></head>"
                + "<body style=\"margin:0;padding:0;background:#f2f6f2;font-family:Arial,Helvetica,sans-serif;color:#202020;\">"
                + "<table role=\"presentation\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"background:#f2f6f2;padding:32px 12px;\"><tr><td align=\"center\">"
                + "<table role=\"presentation\" width=\"560\" cellspacing=\"0\" cellpadding=\"0\" style=\"width:100%;max-width:560px;background:#ffffff;border:1px solid #dfe8e1;border-radius:10px;overflow:hidden;\">"
                + "<tr><td style=\"height:5px;background:" + BRAND_GREEN + ";font-size:0;line-height:0;\">&nbsp;</td></tr>"
                + "<tr><td align=\"center\" style=\"padding:30px 36px 6px;\">" + brand + "</td></tr>"
                + "<tr><td style=\"padding:20px 36px 6px;\">"
                + "<h1 style=\"margin:0 0 12px;font-size:24px;line-height:1.3;color:#202020;\">" + HtmlUtils.htmlEscape(heading) + "</h1>"
                + "<p style=\"margin:0 0 26px;font-size:16px;line-height:1.6;color:#3b463f;\">" + HtmlUtils.htmlEscape(intro) + "</p>"
                + "<table role=\"presentation\" cellspacing=\"0\" cellpadding=\"0\" style=\"margin:0 0 26px;\"><tr><td style=\"background:" + BRAND_GREEN + ";border-radius:8px;\">"
                + "<a href=\"" + href + "\" style=\"display:inline-block;padding:14px 32px;font-size:16px;font-weight:700;color:#ffffff;text-decoration:none;border-radius:8px;\">"
                + HtmlUtils.htmlEscape(buttonLabel) + "</a></td></tr></table>"
                + "<p style=\"margin:0 0 6px;font-size:13px;color:#6b7a70;\">If the button does not work, copy and paste this link into your browser:</p>"
                + "<p style=\"margin:0 0 24px;font-size:13px;line-height:1.5;word-break:break-all;\"><a href=\"" + href + "\" style=\"color:" + BRAND_GREEN + ";\">" + href + "</a></p>"
                + "</td></tr>"
                + "<tr><td style=\"padding:18px 36px 26px;background:#f8faf8;border-top:1px solid #e6ede8;font-size:12px;line-height:1.6;color:#6b7a70;\">"
                + HtmlUtils.htmlEscape(note) + "<br>&copy; " + Year.now().getValue() + " TeaCode. All rights reserved."
                + "</td></tr></table></td></tr></table></body></html>";
    }

    private void send(String to, String subject, String text, String heading, String intro, String buttonLabel, String link, String note) {
        JavaMailSender sender = senderProvider.getIfAvailable();
        if (sender == null || host.isBlank() || from.isBlank()) {
            log.error("Email is not configured (SMTP_HOST / MAIL_FROM); the message '{}' was NOT sent", subject);
            return;
        }
        boolean logo = LOGO.exists();
        String htmlBody = html(heading, intro, buttonLabel, link, note, logo);
        executor.execute(() -> {
            try {
                MimeMessage message = sender.createMimeMessage();
                MimeMessageHelper helper = new MimeMessageHelper(message, MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED, "UTF-8");
                helper.setFrom(new InternetAddress(from, "TeaCode", "UTF-8"));
                helper.setTo(to);
                helper.setSubject(subject);
                helper.setText(text, htmlBody);
                if (logo) helper.addInline(LOGO_CID, LOGO, "image/png");
                sender.send(message);
            } catch (RuntimeException | MessagingException | UnsupportedEncodingException e) {
                // Recipient and content are deliberately not logged.
                log.error("Sending email '{}' failed: {}", subject, e.getClass().getSimpleName());
            }
        });
    }
}