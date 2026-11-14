package com.teacode.execution;

import com.teacode.config.AppProperties;
import com.teacode.repository.SubmissionJobRepository;
import java.time.Clock;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

/**
 * Fails jobs whose worker disappeared (restart, crash) so users never poll forever, and removes old
 * finished jobs. Safe with several instances: it only touches jobs not updated for a while.
 */
@Component
public class JobMaintenance {

    private static final Logger log = LoggerFactory.getLogger(JobMaintenance.class);

    private final SubmissionJobRepository jobs;
    private final AppProperties props;
    private final Clock clock;

    public JobMaintenance(SubmissionJobRepository jobs, AppProperties props, Clock clock) {
        this.jobs = jobs;
        this.props = props;
        this.clock = clock;
    }

    private LocalDateTime now() {
        return LocalDateTime.now(clock.withZone(ZoneOffset.UTC));
    }

    @Scheduled(fixedDelay = 60_000, initialDelay = 15_000)
    @Transactional
    public void failStaleJobs() {
        // Longer than the polling deadline plus several batches, so a live job is never cut off.
        int n = jobs.failStale(now().minusSeconds(Math.max(300, props.jdoodle().jobDeadlineSeconds() * 2L)));
        if (n > 0) {
            log.warn("Marked {} stale execution job(s) as interrupted", n);
        }
    }

    @Scheduled(cron = "0 30 3 * * *", zone = "UTC")
    @Transactional
    public void deleteOldJobs() {
        jobs.deleteFinishedBefore(now().minusDays(7));
    }
}
