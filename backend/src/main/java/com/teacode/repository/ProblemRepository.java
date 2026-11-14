package com.teacode.repository;

import com.teacode.entity.Problem;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ProblemRepository extends JpaRepository<Problem, Long>, JpaSpecificationExecutor<Problem> {

    /**
     * Single lookup used by the detail, starter-code, attempt, timer and execution paths. Only problems owned by
     * TeaCode ({@code source} LOCAL or PACKAGE) are ever returned, so a problem of any other origin cannot be
     * opened, timed or run by slug even if a row of that origin exists.
     */
    @Query("select p from Problem p where p.slug = :slug and p.visibility = :visibility and p.source in ('LOCAL', 'PACKAGE')")
    Optional<Problem> findBySlugAndVisibility(@Param("slug") String slug, @Param("visibility") String visibility);
}
