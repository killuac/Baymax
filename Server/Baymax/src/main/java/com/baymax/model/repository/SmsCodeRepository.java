package com.baymax.model.repository;

import com.baymax.model.entity.SmsCode;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.rest.core.annotation.RestResource;

/**
 * Created by Killua on 7/11/15.
 */
public interface SmsCodeRepository extends CrudRepository<SmsCode, String> {

    @Override
    @RestResource(exported = false)
    SmsCode save(SmsCode entity);
}
