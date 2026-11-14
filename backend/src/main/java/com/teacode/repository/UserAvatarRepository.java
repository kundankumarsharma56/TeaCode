package com.teacode.repository;

import com.teacode.entity.UserAvatar;
import java.time.LocalDateTime;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface UserAvatarRepository extends JpaRepository<UserAvatar, Long> {

    interface Meta {
        String getAvatarKey();
        LocalDateTime getUpdatedAt();
    }

    /** Metadata only: the image bytes are not loaded when building a user response. */
    @Query("select a.avatarKey as avatarKey, a.updatedAt as updatedAt from UserAvatar a where a.userId = :userId")
    Optional<Meta> findMeta(Long userId);

    Optional<UserAvatar> findByAvatarKey(String avatarKey);
}
