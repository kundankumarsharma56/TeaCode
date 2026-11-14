package com.teacode.config;

import java.util.ArrayList;
import java.util.List;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.oauth2.client.CommonOAuth2Provider;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;
import org.springframework.boot.autoconfigure.condition.ConditionalOnExpression;

/**
 * Registers Google and GitHub only when their client id and secret are configured. With neither set there
 * is no repository bean, SecurityConfig leaves OAuth2 login off, and the /oauth2/authorization/* URLs return 404.
 * The redirect URI is built from APP_PUBLIC_URL, so it matches what is registered with the provider.
 */
@Configuration
public class OAuthClientsConfig {

    @Bean
    @ConditionalOnExpression("!'${teacode.oauth.google.client-id:}'.isEmpty() or !'${teacode.oauth.github.client-id:}'.isEmpty()")
    ClientRegistrationRepository clientRegistrationRepository(AppProperties props) {
        String base = props.publicUrl().replaceAll("/+$", "");
        String redirect = base + "/login/oauth2/code/{registrationId}";
        List<ClientRegistration> registrations = new ArrayList<>();
        AppProperties.Provider google = props.oauth().google();
        if (google.enabled()) {
            registrations.add(CommonOAuth2Provider.GOOGLE.getBuilder("google")
                    .clientId(google.clientId()).clientSecret(google.clientSecret()).redirectUri(redirect).build());
        }
        AppProperties.Provider github = props.oauth().github();
        if (github.enabled()) {
            registrations.add(CommonOAuth2Provider.GITHUB.getBuilder("github")
                    .clientId(github.clientId()).clientSecret(github.clientSecret()).redirectUri(redirect)
                    .scope("read:user", "user:email").build());
        }
        if (registrations.isEmpty()) {
            throw new IllegalStateException("OAuth client id is set without its secret (or vice versa)");
        }
        return new InMemoryClientRegistrationRepository(registrations);
    }
}
