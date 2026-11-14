package com.teacode.dto;

/** Response shapes of the dashboard endpoints. */
public final class DashboardDtos {

    private DashboardDtos() {
    }

    /**
     * {@code totalSubmissions} counts every saved submission (attempts). {@code acceptanceRate} is accepted / judged
     * submissions in percent, where service failures and "insufficient verification" are not judged; null when nothing was judged.
     */
    public record Summary(long solvedCount, long totalProblems, long totalSubmissions, long acceptedSubmissions,
                          long attemptedProblems, Double acceptanceRate, long totalTimeMs) {
    }

    public record LanguageStat(String language, long submissions, long accepted) {
    }

    public record TopicStat(String topic, String slug, long attempted, long solved) {
    }

    public record TimeStat(String slug, String title, long timeMs, boolean solved) {
    }

    public record Progress(String difficulty, long solved, long total) {
    }

    public record Activity(String date, long submissions) {
    }

    /** One calendar day (in the caller's UTC offset) that has at least one submission. */
    public record CalendarDay(String date, long submissions, long accepted) {
    }
}
