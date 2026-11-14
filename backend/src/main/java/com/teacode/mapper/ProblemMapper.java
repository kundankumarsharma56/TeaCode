package com.teacode.mapper;

import com.teacode.dto.ProblemDetailDto;
import com.teacode.dto.ProblemSummaryDto;
import com.teacode.dto.SampleCaseDto;
import com.teacode.dto.StarterCodeDto;
import com.teacode.dto.TagDto;
import com.teacode.entity.Problem;
import com.teacode.entity.ProblemStarterCode;
import com.teacode.entity.ProblemTag;
import com.teacode.entity.TestCase;
import java.util.Comparator;
import java.util.List;

public final class ProblemMapper {

    private ProblemMapper() {
    }

    public static TagDto toDto(ProblemTag tag) {
        return new TagDto(tag.getName(), tag.getSlug());
    }

    private static List<TagDto> tags(Problem p) {
        return p.getTags().stream()
                .sorted(Comparator.comparing(ProblemTag::getName))
                .map(ProblemMapper::toDto)
                .toList();
    }

    /** {@code solved}/{@code timeSpentMs} are null for anonymous users. */
    public static ProblemSummaryDto toSummary(Problem p, Boolean solved, Long timeSpentMs) {
        return new ProblemSummaryDto(p.getSlug(), p.getTitle(), p.getDifficulty(), p.getRating(), p.getSource(), tags(p), solved, timeSpentMs);
    }

    public static ProblemDetailDto toDetail(Problem p, List<TestCase> samples, long privateTests) {
        List<SampleCaseDto> sampleDtos = samples.stream()
                .map(t -> new SampleCaseDto(t.getInputData(), t.getExpectedOutput()))
                .toList();
        String testData = privateTests > 0 ? "FULL" : (samples.isEmpty() ? "NONE" : "SAMPLES_ONLY");
        boolean judgeable = "STDIN".equals(p.getExecutionModel()) && (!samples.isEmpty() || privateTests > 0);
        return new ProblemDetailDto(p.getSlug(), p.getTitle(), p.getDifficulty(), p.getRating(), p.getSource(), p.getSourceUrl(),
                "AVAILABLE".equals(p.getStatementStatus()) && p.getDescription() != null, testData, judgeable,
                p.getDescription(), p.getConstraintsText(), p.getInputFormat(), p.getOutputFormat(), tags(p), sampleDtos);
    }

    public static StarterCodeDto toDto(ProblemStarterCode s) {
        return new StarterCodeDto(s.getLanguage(), s.getCode());
    }
}
