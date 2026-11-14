package com.teacode.controller;

import com.teacode.entity.UserAvatar;
import com.teacode.service.AvatarService;
import java.time.Duration;
import org.springframework.http.CacheControl;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/** Serves re-encoded avatars by unguessable key. The key changes on every upload, so responses can be cached for long. */
@RestController
@RequestMapping("/api/v1/avatars")
public class AvatarController {

    private final AvatarService avatars;

    public AvatarController(AvatarService avatars) {
        this.avatars = avatars;
    }

    @GetMapping("/{key:[0-9a-f]{32}}")
    public ResponseEntity<byte[]> get(@PathVariable String key) {
        UserAvatar a = avatars.find(key);
        return ResponseEntity.ok()
                .contentType(MediaType.IMAGE_PNG)
                .cacheControl(CacheControl.maxAge(Duration.ofDays(365)).cachePublic().immutable())
                .header("Content-Security-Policy", "default-src 'none'")
                .header("Content-Disposition", "inline")
                .body(a.getData());
    }
}
