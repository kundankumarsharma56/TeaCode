package com.teacode.controller;

import com.teacode.dto.FirebaseLoginRequest;
import com.teacode.dto.ForgotPasswordRequest;
import com.teacode.dto.LoginRequest;
import com.teacode.dto.RegisterRequest;
import com.teacode.dto.ResetPasswordRequest;
import com.teacode.dto.TokenRequest;
import com.teacode.dto.UserResponse;
import com.teacode.exception.ApiException;
import com.teacode.security.AuthUser;
import com.teacode.security.CookieService;
import com.teacode.security.FirebaseTokenVerifier;
import com.teacode.security.OAuthLoginException;
import com.teacode.security.OAuthProfile;
import com.teacode.service.AccountService;
import com.teacode.service.AuthService;
import com.teacode.service.AuthService.AuthResult;
import com.teacode.service.OAuthLoginService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/auth")
public class AuthController {

    private final AuthService auth;
    private final AccountService accounts;
    private final CookieService cookies;
    private final FirebaseTokenVerifier firebase;
    private final OAuthLoginService externalLogin;

    public AuthController(AuthService auth, AccountService accounts, CookieService cookies,
                          FirebaseTokenVerifier firebase, OAuthLoginService externalLogin) {
        this.auth = auth;
        this.accounts = accounts;
        this.cookies = cookies;
        this.firebase = firebase;
        this.externalLogin = externalLogin;
    }

    /**
     * Passwordless sign-in and sign-up. The browser completes Firebase's email-link flow and sends the resulting
     * ID token here. The token is verified server-side, then the user gets the same HttpOnly session cookies as any
     * other sign-in. Only an email Firebase reports as verified is accepted.
     */
    @PostMapping("/firebase")
    public ResponseEntity<UserResponse> firebaseSignIn(@Valid @RequestBody FirebaseLoginRequest request, HttpServletRequest http) {
        OAuthProfile profile = firebase.verify(request.idToken());
        AuthResult result;
        try {
            result = externalLogin.signIn(profile, http.getRemoteAddr());
        } catch (OAuthLoginException e) {
            throw refusal(e);
        }
        return cookies.withSession(ResponseEntity.ok(), result.accessToken(), result.refreshToken()).body(result.user());
    }

    private static ApiException refusal(OAuthLoginException e) {
        return switch (e.getCode()) {
            case "account_disabled" -> new ApiException(HttpStatus.FORBIDDEN, "ACCOUNT_DISABLED", "This account is disabled.");
            case "email_unverified" -> new ApiException(HttpStatus.FORBIDDEN, "EMAIL_UNVERIFIED", "Your email address could not be verified.");
            default -> new ApiException(HttpStatus.BAD_REQUEST, "SIGN_IN_FAILED", "Sign-in failed. Please try again.");
        };
    }

    @PostMapping("/register")
    public ResponseEntity<Void> register(@Valid @RequestBody RegisterRequest request, HttpServletRequest http) {
        auth.register(request, http.getRemoteAddr());
        return ResponseEntity.accepted().build();
    }

    @PostMapping("/login")
    public ResponseEntity<UserResponse> login(@Valid @RequestBody LoginRequest request, HttpServletRequest http) {
        AuthResult result = auth.login(request.email(), request.password(), http.getRemoteAddr());
        return cookies.withSession(ResponseEntity.ok(), result.accessToken(), result.refreshToken()).body(result.user());
    }

    @PostMapping("/refresh")
    public ResponseEntity<Void> refresh(@CookieValue(name = CookieService.REFRESH, required = false) String refreshToken,
                                        HttpServletRequest http) {
        AuthResult result = auth.refresh(refreshToken, http.getRemoteAddr());
        return cookies.withSession(ResponseEntity.status(HttpStatus.NO_CONTENT), result.accessToken(), result.refreshToken()).build();
    }

    @PostMapping("/logout")
    public ResponseEntity<Void> logout(@CookieValue(name = CookieService.REFRESH, required = false) String refreshToken,
                                       HttpServletRequest http) {
        auth.logout(refreshToken, http.getRemoteAddr());
        return cookies.withClearedSession(ResponseEntity.status(HttpStatus.NO_CONTENT)).build();
    }

    @GetMapping("/me")
    public UserResponse me(@AuthenticationPrincipal AuthUser user) {
        return accounts.me(user.id());
    }

    @PostMapping("/verify-email")
    public ResponseEntity<Void> verifyEmail(@Valid @RequestBody TokenRequest request, HttpServletRequest http) {
        auth.verifyEmail(request.token(), http.getRemoteAddr());
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/forgot-password")
    public ResponseEntity<Void> forgotPassword(@Valid @RequestBody ForgotPasswordRequest request, HttpServletRequest http) {
        auth.forgotPassword(request.email(), http.getRemoteAddr());
        return ResponseEntity.accepted().build();
    }

    @PostMapping("/reset-password")
    public ResponseEntity<Void> resetPassword(@Valid @RequestBody ResetPasswordRequest request, HttpServletRequest http) {
        auth.resetPassword(request.token(), request.password(), http.getRemoteAddr());
        return ResponseEntity.noContent().build();
    }
}
