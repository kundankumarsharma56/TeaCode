package com.teacode.service;

import com.teacode.exception.TooManyRequestsException;
import io.github.bucket4j.Bandwidth;
import io.github.bucket4j.Bucket;
import java.time.Duration;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;
import org.springframework.stereotype.Component;

/**
 * In-memory token-bucket limiter (Bucket4j). Per instance only: with several backend instances every instance
 * enforces its own counters, so the effective limit is multiplied by the instance count. For multi-instance
 * deployments the buckets must move to a shared store (for example Redis or the database); that is NOT implemented.
 *
 * Memory is bounded: at most {@link #MAX_ENTRIES} distinct keys are tracked. When the map is full of live entries,
 * new keys share one coarse bucket per scope instead of growing the map, so an attacker rotating keys cannot exhaust
 * memory, and cleanup runs at most once per {@link #EVICT_INTERVAL_MILLIS} so it cannot be turned into a CPU amplifier.
 */
@Component
public class RateLimiter {

    static final int MAX_ENTRIES = 20_000;
    private static final long EVICT_INTERVAL_MILLIS = 5_000;
    /** Shared fallback is deliberately generous per scope: it only protects the process, not individual users. */
    private static final int OVERFLOW_MULTIPLIER = 20;

    private record Entry(Bucket bucket, long createdAtMillis, long windowMillis) {
    }

    private final ConcurrentHashMap<String, Entry> buckets = new ConcurrentHashMap<>();
    private final AtomicLong lastEvict = new AtomicLong();

    /** Consumes one token for {@code scope:key} or throws TooManyRequestsException. */
    public void check(String scope, String key, int capacity, Duration window) {
        String id = scope + ":" + (key == null ? "unknown" : key);
        Entry entry = buckets.get(id);
        if (entry == null) {
            if (buckets.size() >= MAX_ENTRIES) {
                evictIdle();
            }
            if (buckets.size() >= MAX_ENTRIES) {
                id = scope + ":*overflow";
                capacity = capacity * OVERFLOW_MULTIPLIER;
            }
            final int cap = capacity;
            entry = buckets.computeIfAbsent(id, k -> newEntry(cap, window));
        }
        if (!entry.bucket().tryConsume(1)) {
            throw new TooManyRequestsException();
        }
    }

    int size() {
        return buckets.size();
    }

    private static Entry newEntry(int capacity, Duration window) {
        Bandwidth limit = Bandwidth.builder().capacity(capacity).refillIntervally(capacity, window).build();
        return new Entry(Bucket.builder().addLimit(limit).build(), System.currentTimeMillis(), window.toMillis());
    }

    /** Drops buckets older than twice their window (they would be full again anyway); throttled. */
    private void evictIdle() {
        long now = System.currentTimeMillis();
        long last = lastEvict.get();
        if (now - last < EVICT_INTERVAL_MILLIS || !lastEvict.compareAndSet(last, now)) {
            return;
        }
        buckets.entrySet().removeIf(e -> now - e.getValue().createdAtMillis() > 2 * e.getValue().windowMillis());
    }
}
