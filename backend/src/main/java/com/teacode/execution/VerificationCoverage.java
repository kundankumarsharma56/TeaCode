package com.teacode.execution;

import com.teacode.entity.ReferenceSolution;
import java.util.Collection;
import java.util.Map;

/**
 * Pure rules for "is this problem verified in every required language". A language with no reference solution, or
 * one that is UNVERIFIED or FAILED, counts as not verified, so a problem is never reported fully verified by default.
 */
public final class VerificationCoverage {

    private VerificationCoverage() {
    }

    /** True only when every required language has a VERIFIED solution. An empty requirement is never "verified". */
    public static boolean fullyVerified(Collection<String> requiredLanguages, Map<String, String> statusByLanguage) {
        if (requiredLanguages.isEmpty()) {
            return false;
        }
        return requiredLanguages.stream().allMatch(l -> ReferenceSolution.VERIFIED.equals(statusByLanguage.get(l)));
    }

    /** Languages still blocking full verification (missing, unverified or failed), in the order given. */
    public static java.util.List<String> missing(Collection<String> requiredLanguages, Map<String, String> statusByLanguage) {
        return requiredLanguages.stream().filter(l -> !ReferenceSolution.VERIFIED.equals(statusByLanguage.get(l))).toList();
    }
}
