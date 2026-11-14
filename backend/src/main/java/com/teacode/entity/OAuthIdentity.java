package com.teacode.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

/** Link between a local account and a sign-in provider identity. Holds no provider tokens. */
@Entity
@Table(name = "oauth_identities")
public class OAuthIdentity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "provider", nullable = false, length = 20)
    private String provider;

    @Column(name = "provider_user_id", nullable = false, length = 100)
    private String providerUserId;

    @Column(name = "avatar_url", length = 500)
    private String avatarUrl;

    protected OAuthIdentity() {
    }

    public OAuthIdentity(Long userId, String provider, String providerUserId, String avatarUrl) {
        this.userId = userId;
        this.provider = provider;
        this.providerUserId = providerUserId;
        this.avatarUrl = avatarUrl;
    }

    public Long getId() { return id; }
    public Long getUserId() { return userId; }
    public String getProvider() { return provider; }
    public String getProviderUserId() { return providerUserId; }
    public String getAvatarUrl() { return avatarUrl; }
    public void setAvatarUrl(String avatarUrl) { this.avatarUrl = avatarUrl; }
}
