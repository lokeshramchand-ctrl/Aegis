package com.aegis.aegis_backend.controller;

import org.hibernate.service.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.aegis.aegis_backend.service.MfaService;

@RestController
@RequestMapping("/mfa")
public class MfaController {
    private final MfaService mfaService;

    public MfaController(MfaService service) {
        this.service = service;
    }

    @PostMapping("/enroll")
    public MfaEnrollResponse enroll(
        @RequestHeader("X-User-ID") String userId
    ) {
        return Service.enroll(userId);
}
}