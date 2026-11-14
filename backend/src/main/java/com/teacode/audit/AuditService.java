package com.teacode.audit;

import com.teacode.config.AppProperties;
import com.teacode.config.CorrelationIdFilter;
import com.teacode.entity.AuditEvent;
import com.teacode.repository.AuditEventRepository;
import com.teacode.security.TokenService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.stereotype.Service;

/**
 * Records security events. Callers pass only an event name, outcome and a short non-sensitive detail.
 * The client address is stored as a salted hash. Failures to write an audit row never break the request.
 */
@Service
public class AuditService {

    private static final Logger log = LoggerFactory.getLogger(AuditService.class);

    private final AuditEventRepository repository;
    private final String salt;

    public AuditService(AuditEventRepository repository, AppProperties props) {
        this.repository = repository;
        this.salt = props.security().jwtSecret();
    }

    public void record(Long userId, String eventType, String outcome, String ip, String detail) {
        try {
            String ipHash = ip == null ? null : TokenService.sha256Hex(ip + ":" + salt);
            String safeDetail = detail == null ? null : detail.substring(0, Math.min(detail.length(), 500));
            repository.save(new AuditEvent(userId, eventType, outcome, MDC.get(CorrelationIdFilter.MDC_KEY), ipHash, safeDetail));
        } catch (RuntimeException e) {
            log.warn("Could not write audit event {}", eventType, e);
        }
    }
}
