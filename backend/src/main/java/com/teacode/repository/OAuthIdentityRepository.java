package com.teacode.repository;

import com.teacode.entity.OAuthIdentity;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OAuthIdentityRepository extends JpaRepository<OAuthIdentity, Long> {

    Optional<OAuthIdentity> findByProviderAndProviderUserId(String provider, String providerUserId);

    List<OAuthIdentity> findByUserId(Long userId);
}
