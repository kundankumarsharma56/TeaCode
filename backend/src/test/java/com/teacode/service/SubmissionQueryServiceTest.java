package com.teacode.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import com.teacode.exception.BadRequestException;
import com.teacode.repository.ProblemRepository;
import com.teacode.repository.SubmissionRepository;
import java.time.LocalDateTime;
import java.util.List;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

/** Validation and scoping of the history queries. The SQL itself is exercised by the integration tests (need Docker). */
class SubmissionQueryServiceTest {

    private final SubmissionRepository repo = mock(SubmissionRepository.class);
    private final SubmissionQueryService service = new SubmissionQueryService(repo, mock(ProblemRepository.class));

    private static SubmissionQueryService.Filters f(String status, String language, String difficulty, String q, String from,
                                                    String to, int off) {
        return new SubmissionQueryService.Filters(status, language, null, difficulty, q, from, to, off);
    }

    @Test
    void rejectsOversizedPagesAndBadFilters() {
        assertThatThrownBy(() -> service.practiceHistory(1, 0, 51, SubmissionQueryService.Filters.none()))
                .isInstanceOf(BadRequestException.class);
        assertThatThrownBy(() -> service.practiceHistory(1, -1, 10, SubmissionQueryService.Filters.none()))
                .isInstanceOf(BadRequestException.class);
        assertThatThrownBy(() -> service.practiceHistory(1, 0, 10, f("accepted; drop", null, null, null, null, null, 0)))
                .isInstanceOf(BadRequestException.class);
        assertThatThrownBy(() -> service.practiceHistory(1, 0, 10, f(null, null, "IMPOSSIBLE", null, null, null, 0)))
                .isInstanceOf(BadRequestException.class);
        assertThatThrownBy(() -> service.practiceHistory(1, 0, 10, f(null, null, null, null, "13/11/2026", null, 0)))
                .isInstanceOf(BadRequestException.class);
        assertThatThrownBy(() -> service.practiceHistory(1, 0, 10, f(null, null, null, null, "2026-11-10", "2026-11-01", 0)))
                .isInstanceOf(BadRequestException.class);
    }

    @Test
    void scopesToTheCallerAndConvertsLocalDatesToUtc() {
        when(repo.practiceHistory(any(), any(), any(), any(), any(), any(), any(), any(Pageable.class)))
                .thenReturn(Page.empty());
        // UTC+05:30: local 2026-11-07 starts at 2026-11-06T18:30Z and the range ends at 2026-11-07T18:30Z.
        service.practiceHistory(42, 0, 20, f("ACCEPTED", "python", "easy", " Two ", "2026-11-07", "2026-11-07", 330));
        ArgumentCaptor<LocalDateTime> from = ArgumentCaptor.forClass(LocalDateTime.class);
        ArgumentCaptor<LocalDateTime> to = ArgumentCaptor.forClass(LocalDateTime.class);
        verify(repo).practiceHistory(eq(42L), eq("ACCEPTED"), eq("python"), eq("EASY"), eq("%two%"), from.capture(),
                to.capture(), any(Pageable.class));
        assertThat(from.getValue()).isEqualTo(LocalDateTime.parse("2026-11-06T18:30:00"));
        assertThat(to.getValue()).isEqualTo(LocalDateTime.parse("2026-11-07T18:30:00"));
    }

    @Test
    void emptyHistoryDoesNotQueryStatuses() {
        when(repo.practiceHistory(any(), any(), any(), any(), any(), any(), any(), any(Pageable.class)))
                .thenReturn(new PageImpl<SubmissionRepository.HistoryRow>(List.of()));
        assertThat(service.practiceHistory(1, 0, 10, SubmissionQueryService.Filters.none()).items()).isEmpty();
    }
}
