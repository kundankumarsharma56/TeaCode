# Firebase and email verification status

## Current authentication flow

The current password-based UI uses the existing Spring Boot authentication endpoints:

- `POST /api/v1/auth/register` creates an account and records Terms/Privacy acceptance.
- The backend creates a single-use verification token and sends the link through the configured SMTP mailer.
- `/verify-email?token=...` submits the token to `POST /api/v1/auth/verify-email`.
- `POST /api/v1/auth/login` accepts only active accounts with a verified email address.
- Password recovery uses `POST /api/v1/auth/forgot-password` and `POST /api/v1/auth/reset-password`.

This is **not Firebase Auth email verification**. Firebase ID-token verification and the previous passwordless email-link helper remain in the codebase for the separate Firebase sign-in endpoint, but the current password form does not use that flow.

## SMTP configuration required for current email verification

Set `APP_PUBLIC_URL` to the public HTTPS origin and configure `MAIL_FROM`, `SMTP_HOST`, `SMTP_PORT`, `SMTP_USERNAME`, and `SMTP_PASSWORD` in `.env`. The verification and reset URLs are generated from `APP_PUBLIC_URL`; do not point it at an untrusted host. Use a real sender domain with SPF, DKIM and DMARC configured. Never commit SMTP credentials.

## If Firebase Auth email verification is a firm requirement

Do not merely change the frontend form. Plan and implement an identity migration using Firebase Auth email/password account creation, `sendEmailVerification`, verified Firebase ID tokens, and a server-side mapping from Firebase UID/email to TeaCode users. Define how existing password hashes, account linking, username uniqueness, policy acceptance, password reset, account deletion and OAuth identities migrate. Add integration tests against a dedicated Firebase test project before switching production traffic. The previous `docs/firebase-setup.md` instructions were superseded by this status note; no live Firebase project has been configured or verified by this delivery.
