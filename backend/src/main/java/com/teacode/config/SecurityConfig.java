package com.teacode.config;

import com.teacode.repository.RefreshSessionRepository;
import com.teacode.repository.UserRepository;
import com.teacode.security.CsrfCookieFilter;
import com.teacode.security.ForbiddenRequestLogger;
import com.teacode.security.GithubEmailUserService;
import com.teacode.security.JwtAuthenticationFilter;
import com.teacode.security.OAuthLoginHandlers;
import com.teacode.security.JwtService;
import java.time.Clock;
import java.util.List;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.context.annotation.Bean;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.HttpStatusEntryPoint;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.security.web.csrf.CsrfTokenRequestAttributeHandler;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

/**
 * Stateless cookie-based security. The browser app is served from the same origin as the API, so CORS
 * is limited to the single configured public origin (never a wildcard) and is only needed if the
 * frontend is ever hosted on a different origin.
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    SecurityFilterChain filterChain(HttpSecurity http, JwtService jwt, RefreshSessionRepository sessions,
                                    UserRepository users, Clock clock, AppProperties props,
                                    ObjectProvider<ClientRegistrationRepository> oauthClients,
                                    OAuthLoginHandlers oauthHandlers) throws Exception {
        // The CSRF cookie must be readable by the SPA (it echoes it in X-XSRF-TOKEN), so it is not HttpOnly.
        CookieCsrfTokenRepository csrfRepo = CookieCsrfTokenRepository.withHttpOnlyFalse();
        boolean secure = props.security().cookieSecure();
        csrfRepo.setCookieCustomizer(c -> c.secure(secure).sameSite("Lax").path("/"));

        http
                .sessionManagement(s -> s.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)) // no sessions except the OAuth2 handshake
                .cors(Customizer.withDefaults())
                .csrf(csrf -> csrf
                        // The public Terminal needs no account and no cookie. Its two endpoints act on nobody's identity and
                        // return nothing a third-party page could use without the one-use session token, so CSRF protection
                        // adds nothing there and only makes anonymous visitors fail when the CSRF cookie is missing.
                        .ignoringRequestMatchers(
                                org.springframework.security.web.util.matcher.AntPathRequestMatcher.antMatcher(HttpMethod.POST, "/api/v1/terminal/run"),
                                org.springframework.security.web.util.matcher.AntPathRequestMatcher.antMatcher(HttpMethod.POST, "/api/v1/terminal/sessions"))
                        .csrfTokenRepository(csrfRepo)
                        // The cookie value is sent back as-is, so the plain (non-XOR) handler is correct for a SPA.
                        .csrfTokenRequestHandler(new CsrfTokenRequestAttributeHandler()))
                .httpBasic(b -> b.disable())
                .formLogin(f -> f.disable())
                .logout(l -> l.disable())
                .exceptionHandling(e -> e.authenticationEntryPoint(new HttpStatusEntryPoint(HttpStatus.UNAUTHORIZED)))
                // Outermost: sees the final status of CORS, CSRF and authorization rejections and logs the reason of any 403.
                .addFilterBefore(new ForbiddenRequestLogger(props.publicUrl()), CorsFilter.class)
                .addFilterBefore(new JwtAuthenticationFilter(jwt, sessions, users, clock), UsernamePasswordAuthenticationFilter.class)
                .addFilterAfter(new CsrfCookieFilter(), CsrfFilter.class)
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers(HttpMethod.GET, "/api/v1/problems", "/api/v1/problems/**").permitAll()
                        .requestMatchers(HttpMethod.GET, "/api/v1/execution/languages", "/api/v1/terminal/languages").permitAll()
                        // Anonymous access is limited to the standalone compiler and UUID-addressed jobs.
                        .requestMatchers(HttpMethod.POST, "/api/v1/terminal/run", "/api/v1/terminal/sessions").permitAll()
                        .requestMatchers(HttpMethod.GET, "/api/v1/submissions/jobs/*").permitAll()
                        .requestMatchers(HttpMethod.GET, "/api/v1/avatars/*").permitAll()
                        .requestMatchers(HttpMethod.GET, "/oauth2/authorization/*", "/login/oauth2/code/*").permitAll()
                        .requestMatchers(HttpMethod.POST,
                                "/api/v1/auth/register", "/api/v1/auth/login", "/api/v1/auth/logout",
                                "/api/v1/auth/refresh", "/api/v1/auth/verify-email", "/api/v1/auth/firebase",
                                "/api/v1/auth/forgot-password", "/api/v1/auth/reset-password").permitAll()
                        .requestMatchers("/actuator/health", "/actuator/health/**", "/actuator/info").permitAll()
                        // Metrics are operational data: administrators only (and the proxy does not expose /actuator).
                        .requestMatchers("/actuator/**").hasRole("ADMIN")
                        .anyRequest().authenticated());
        if (oauthClients.getIfAvailable() != null) {
            http.oauth2Login(o -> o
                    .successHandler(oauthHandlers)
                    .failureHandler(oauthHandlers)
                    .userInfoEndpoint(u -> u.userService(new GithubEmailUserService())));
        }
        return http.build();
    }

    @Bean
    CorsConfigurationSource corsConfigurationSource(AppProperties props) {
        CorsConfiguration cfg = new CorsConfiguration();
        cfg.setAllowedOrigins(List.of(props.publicUrl()));   // exact origin, never "*"
        cfg.setAllowedMethods(List.of("GET", "POST", "PATCH", "DELETE"));
        cfg.setAllowedHeaders(List.of("Content-Type", "X-XSRF-TOKEN", "X-Correlation-Id"));
        cfg.setAllowCredentials(true);
        cfg.setMaxAge(600L);
        // The public Terminal is anonymous and credential-less, so it is reachable from any address the site is served on.
        // Registered first: the first matching pattern wins. No cookies are allowed on this path.
        CorsConfiguration publicTerminal = new CorsConfiguration();
        publicTerminal.setAllowedOriginPatterns(List.of("*"));
        publicTerminal.setAllowedMethods(List.of("POST", "GET"));
        publicTerminal.setAllowedHeaders(List.of("Content-Type", "X-Correlation-Id"));
        publicTerminal.setAllowCredentials(false);
        publicTerminal.setMaxAge(600L);
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/api/v1/terminal/**", publicTerminal);
        source.registerCorsConfiguration("/api/v1/submissions/jobs/*", publicTerminal);
        source.registerCorsConfiguration("/api/v1/execution/languages", publicTerminal);
        source.registerCorsConfiguration("/api/**", cfg);
        return source;
    }
}
