package com.teacode.service;

import com.teacode.dto.UserResponse;
import com.teacode.entity.OAuthIdentity;
import com.teacode.entity.User;
import com.teacode.repository.OAuthIdentityRepository;
import com.teacode.repository.UserAvatarRepository;
import java.time.ZoneOffset;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import org.springframework.stereotype.Service;

/** Builds the UserResponse, including linked sign-in providers and which avatar is active. */
@Service
public class UserViewService {

    public static final String AVATAR_PATH = "/api/v1/avatars/";
    private static final Map<String, String> DISPLAY = Map.of("google", "Google", "github", "GitHub");

    private final OAuthIdentityRepository identities;
    private final UserAvatarRepository avatars;

    public UserViewService(OAuthIdentityRepository identities, UserAvatarRepository avatars) {
        this.identities = identities;
        this.avatars = avatars;
    }

    public UserResponse view(User u) {
        List<OAuthIdentity> linked = identities.findByUserId(u.getId());
        List<String> providers = linked.stream().map(i -> DISPLAY.getOrDefault(i.getProvider(), i.getProvider())).sorted().toList();
        Optional<String> providerAvatar = linked.stream().map(OAuthIdentity::getAvatarUrl)
                .filter(url -> url != null && !url.isBlank()).findFirst();
        Optional<UserAvatarRepository.Meta> custom = avatars.findMeta(u.getId());

        String url = null;
        String source = null;
        boolean useCustom = custom.isPresent() && ("CUSTOM".equals(u.getAvatarPreference()) || providerAvatar.isEmpty());
        if (useCustom) {
            url = AVATAR_PATH + custom.get().getAvatarKey();
            source = "CUSTOM";
        } else if (providerAvatar.isPresent()) {
            url = providerAvatar.get();
            source = "PROVIDER";
        }
        return new UserResponse(u.getUsername(), u.getEmail(), u.isEmailVerified(),
                u.getCreatedAt() == null ? null : u.getCreatedAt().toInstant(ZoneOffset.UTC),
                providers, url, source, providerAvatar.isPresent());
    }
}
