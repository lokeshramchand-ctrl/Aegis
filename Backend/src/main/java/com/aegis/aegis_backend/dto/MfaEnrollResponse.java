package com.aegis.aegis_backend.dto;

import com.aegis.aegis_backend.entity.MfaSecret;

public class MfaEnrollResponse enroll(String userId){

    String secret = generateSecret();

    String otpauth = String.format("otpauth://totp/Aegis:%s?secret=%s&issuer=Aegis" , userId, secret);

    MfaSecret entity = new MfaSecret();
    entity.setUserId(userId);
    entity.setEncryptedString(secret);
    entity.setStatus(MfaSecret.Status.PENDING);

    repo.save(entity);

    String qr  = QrCodeUtil.toBase63Png(otpauth);

    return new MfaEnrollResponse(qr);
    
}
