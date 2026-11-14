package com.teacode;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.UserDetailsServiceAutoConfiguration;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;

// No in-memory default user: authentication is implemented explicitly in Phase 4.
@ConfigurationPropertiesScan
@SpringBootApplication(exclude = UserDetailsServiceAutoConfiguration.class)
public class TeaCodeApplication {
    public static void main(String[] args) {
        SpringApplication.run(TeaCodeApplication.class, args);
    }
}
