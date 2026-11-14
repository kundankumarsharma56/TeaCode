package com.teacode.controller;

import com.teacode.dto.ChangePasswordRequest;
import com.teacode.dto.DeleteAccountRequest;
import com.teacode.dto.UpdateProfileRequest;
import com.teacode.dto.UserResponse;
import com.teacode.security.AuthUser;
import com.teacode.security.CookieService;
import com.teacode.exception.BadRequestException;
import com.teacode.service.AccountService;
import com.teacode.service.AvatarService;
import java.io.IOException;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/users/me")
public class UserController {

    private final AccountService accounts;
    private final AvatarService avatars;
    private final CookieService cookies;

    public UserController(AccountService accounts, AvatarService avatars, CookieService cookies) {
        this.accounts = accounts;
        this.avatars = avatars;
        this.cookies = cookies;
    }

    @GetMapping
    public UserResponse me(@AuthenticationPrincipal AuthUser user) {
        return accounts.me(user.id());
    }

    @PatchMapping
    public UserResponse update(@AuthenticationPrincipal AuthUser user, @Valid @RequestBody UpdateProfileRequest request) {
        return accounts.updateUsername(user.id(), request.username());
    }

    /** Multipart field "file". Validated and re-encoded server-side; returns the updated profile. */
    @PostMapping(value = "/avatar", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public UserResponse uploadAvatar(@AuthenticationPrincipal AuthUser user, @RequestPart("file") MultipartFile file) throws IOException {
        if (file.getSize() > AvatarService.MAX_BYTES) {
            throw new BadRequestException("The image must be 2 MB or smaller.");
        }
        return avatars.upload(user.id(), file.getBytes());
    }

    @DeleteMapping("/avatar")
    public UserResponse removeAvatar(@AuthenticationPrincipal AuthUser user) {
        return avatars.remove(user.id());
    }

    @PostMapping("/change-password")
    public ResponseEntity<Void> changePassword(@AuthenticationPrincipal AuthUser user,
                                               @Valid @RequestBody ChangePasswordRequest request, HttpServletRequest http) {
        accounts.changePassword(user.id(), request.currentPassword(), request.newPassword(), http.getRemoteAddr());
        return cookies.withClearedSession(ResponseEntity.status(HttpStatus.NO_CONTENT)).build();
    }

    @DeleteMapping
    public ResponseEntity<Void> delete(@AuthenticationPrincipal AuthUser user,
                                       @Valid @RequestBody DeleteAccountRequest request, HttpServletRequest http) {
        accounts.deleteAccount(user.id(), request.password(), http.getRemoteAddr());
        return cookies.withClearedSession(ResponseEntity.status(HttpStatus.NO_CONTENT)).build();
    }
}
