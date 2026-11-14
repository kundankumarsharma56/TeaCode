package com.teacode.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;

/** Re-encoded avatar image. {@code avatarKey} is random, so image URLs cannot be enumerated by user id. */
@Entity
@Table(name = "user_avatars")
public class UserAvatar {

    @Id
    @Column(name = "user_id")
    private Long userId;

    @Column(name = "avatar_key", nullable = false, length = 32, columnDefinition = "char(32)")
    private String avatarKey;

    @Column(name = "content_type", nullable = false, length = 30)
    private String contentType;

    @Column(name = "data", nullable = false, columnDefinition = "mediumblob")
    private byte[] data;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    protected UserAvatar() {
    }

    public UserAvatar(Long userId, String avatarKey, String contentType, byte[] data, LocalDateTime updatedAt) {
        this.userId = userId;
        this.avatarKey = avatarKey;
        this.contentType = contentType;
        this.data = data;
        this.updatedAt = updatedAt;
    }

    public Long getUserId() { return userId; }
    public String getAvatarKey() { return avatarKey; }
    public String getContentType() { return contentType; }
    public byte[] getData() { return data; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
}
