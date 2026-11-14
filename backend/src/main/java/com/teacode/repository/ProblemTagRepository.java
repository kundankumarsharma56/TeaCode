package com.teacode.repository;

import com.teacode.entity.ProblemTag;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ProblemTagRepository extends JpaRepository<ProblemTag, Long> {

    /** Tags attached to at least one published problem. */
    @Query("select distinct t from Problem p join p.tags t where p.visibility = 'PUBLISHED' and p.source in ('LOCAL', 'PACKAGE') order by t.name")
    List<ProblemTag> findTagsOfPublishedProblems();
}
