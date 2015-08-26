package com.baymax.model.service;

import com.baymax.model.entity.SmsCode;
import com.baymax.model.repository.SmsCodeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Killua on 7/11/15.
 */

@Service
public class SmsCodeService {

    private final SmsCodeRepository smsCodeRepository;

    @Autowired
    public SmsCodeService(SmsCodeRepository smsCodeRepository) {
        this.smsCodeRepository = smsCodeRepository;
    }

    public void save(SmsCode smsCode) {
        smsCodeRepository.save(smsCode);
    }

    public void delete(SmsCode smsCode) {
        smsCodeRepository.delete(smsCode);
    }
}
