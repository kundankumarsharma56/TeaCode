package com.teacode.security;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.OAuth2Error;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.web.client.RestClient;
import org.springframework.web.client.RestClientException;

/**
 * GitHub's /user response often has no email. This asks GitHub for the account's emails and keeps only
 * the PRIMARY address that GitHub marks VERIFIED. If there is none, email stays absent and sign-in is refused.
 */
public class GithubEmailUserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User> {

    private record GithubEmail(String email, boolean primary, boolean verified) {
    }

    private final DefaultOAuth2UserService delegate = new DefaultOAuth2UserService();
    private final RestClient client = RestClient.create();

    @Override
    public OAuth2User loadUser(OAuth2UserRequest request) throws OAuth2AuthenticationException {
        OAuth2User user = delegate.loadUser(request);
        if (!"github".equals(request.getClientRegistration().getRegistrationId())) {
            return user;
        }
        Map<String, Object> attributes = new HashMap<>(user.getAttributes());
        attributes.remove("email"); // the public profile email is not proof of ownership
        try {
            List<GithubEmail> emails = client.get().uri("https://api.github.com/user/emails")
                    .header("Authorization", "Bearer " + request.getAccessToken().getTokenValue())
                    .header("Accept", "application/vnd.github+json")
                    .retrieve().body(new ParameterizedTypeReference<List<GithubEmail>>() { });
            if (emails != null) {
                emails.stream().filter(e -> e.primary() && e.verified()).findFirst().ifPresent(e -> {
                    attributes.put("email", e.email());
                    attributes.put("email_verified", Boolean.TRUE);
                });
            }
        } catch (RestClientException e) {
            throw new OAuth2AuthenticationException(new OAuth2Error("email_lookup_failed"), "Could not read the GitHub email", e);
        }
        return new DefaultOAuth2User(user.getAuthorities(), attributes, "id");
    }
}
