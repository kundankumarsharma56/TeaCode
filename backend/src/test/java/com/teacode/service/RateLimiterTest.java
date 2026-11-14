package com.teacode.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import com.teacode.exception.TooManyRequestsException;
import java.time.Duration;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.IntStream;
import org.junit.jupiter.api.Test;

class RateLimiterTest {

    @Test
    void allowsExactlyTheCapacityThenRejects() {
        RateLimiter limiter = new RateLimiter();
        for (int i = 0; i < 3; i++) {
            limiter.check("login", "a@example.com", 3, Duration.ofMinutes(15));
        }
        assertThatThrownBy(() -> limiter.check("login", "a@example.com", 3, Duration.ofMinutes(15)))
                .isInstanceOf(TooManyRequestsException.class);
    }

    @Test
    void keysAndScopesAreIndependent() {
        RateLimiter limiter = new RateLimiter();
        limiter.check("login", "a", 1, Duration.ofMinutes(1));
        limiter.check("login", "b", 1, Duration.ofMinutes(1));
        limiter.check("register", "a", 1, Duration.ofMinutes(1));
        assertThatThrownBy(() -> limiter.check("login", "a", 1, Duration.ofMinutes(1))).isInstanceOf(TooManyRequestsException.class);
    }

    @Test
    void concurrentCallersNeverExceedTheCapacity() throws Exception {
        RateLimiter limiter = new RateLimiter();
        AtomicInteger allowed = new AtomicInteger();
        ExecutorService pool = Executors.newFixedThreadPool(16);
        try {
            IntStream.range(0, 200).mapToObj(i -> pool.submit(() -> {
                try {
                    limiter.check("burst", "same-key", 10, Duration.ofMinutes(1));
                    allowed.incrementAndGet();
                } catch (TooManyRequestsException ignored) {
                    // expected for callers beyond the capacity
                }
            })).toList().forEach(f -> {
                try {
                    f.get();
                } catch (Exception e) {
                    throw new IllegalStateException(e);
                }
            });
        } finally {
            pool.shutdownNow();
        }
        assertThat(allowed.get()).isEqualTo(10);
    }

    @Test
    void memoryStaysBoundedWhenAttackerRotatesKeys() {
        RateLimiter limiter = new RateLimiter();
        for (int i = 0; i < RateLimiter.MAX_ENTRIES + 5_000; i++) {
            try {
                limiter.check("register-ip", "10.0." + (i / 250) + "." + (i % 250) + "-" + i, 10, Duration.ofHours(1));
            } catch (TooManyRequestsException ignored) {
                // the shared overflow bucket may reject; only the size matters here
            }
        }
        // MAX_ENTRIES distinct keys plus one overflow bucket per scope.
        assertThat(limiter.size()).isLessThanOrEqualTo(RateLimiter.MAX_ENTRIES + 1);
    }
}
