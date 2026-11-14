package com.teacode.config;

import java.time.Clock;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.security.crypto.argon2.Argon2PasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableScheduling
public class AppConfig {

    @Bean
    Clock clock() {
        return Clock.systemUTC();
    }

    /** Argon2id, parameters follow the OWASP minimum (19 MiB memory, 2 iterations, 1 lane). */
    @Bean
    PasswordEncoder passwordEncoder() {
        return new Argon2PasswordEncoder(16, 32, 1, 19456, 2);
    }

    /** Bounded pool for judging jobs: a full queue is rejected rather than growing without limit. */
    @Bean(destroyMethod = "shutdown")
    ExecutorService executionExecutor() {
        return new ThreadPoolExecutor(2, 4, 60, TimeUnit.SECONDS,
                new ArrayBlockingQueue<>(50), new ThreadPoolExecutor.AbortPolicy());
    }

    /** Sends email off the request thread so response time does not reveal whether an account exists. */
    @Bean(destroyMethod = "shutdown")
    ExecutorService mailExecutor() {
        return new ThreadPoolExecutor(1, 2, 60, TimeUnit.SECONDS,
                new ArrayBlockingQueue<>(200), new ThreadPoolExecutor.DiscardPolicy());
    }
}
