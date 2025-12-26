package com.aegis.aegis_backend.service;

import java.security.SecureRandom;
import java.util.Base64;

import org.apache.commons.codec.binary.Base32;
import org.springframework.stereotype.Service;

import com.aegis.aegis_backend.repository.MFASecretRepository;

@Service
public class MfaService {
    private final MFASecretRepository repo;

    public MfaService(MFASec    retRepository repo) {
        this.repo = repo;
    }

    public String generateSecret()
    {
        byte[] buffer = new byte[20];
        new SecureRandom().nextBytes(buffer);
        return new Base32().encodeToString(buffer);
    }
}
