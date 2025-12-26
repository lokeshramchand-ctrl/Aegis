package com.aegis.auth.repository;

import com.aegis.auth.entity.MfaSecret;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface MfaSecretRepository extends JpaRepository<MfaSecret, UUID> {
    Optional<MfaSecret> findByUserId(String userId);
}