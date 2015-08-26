package com.baymax.controller;

import com.baymax.model.entity.SmsCode;
import com.baymax.model.service.SmsCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.util.Date;
import java.util.Random;

import static com.baymax.common.CustomProperties.propertiesInstance;

/**
 * Created by Killua on 7/11/15.
 */

@RestController
@RequestMapping("/api/smsCodes")
public class SmsCodeController {

    private final SmsCodeService smsCodeService;
    private final ThreadPoolTaskScheduler taskScheduler;

    @Autowired
    public SmsCodeController(SmsCodeService smsCodeService, ThreadPoolTaskScheduler taskScheduler) {
        this.smsCodeService = smsCodeService;
        this.taskScheduler = taskScheduler;
    }

    @RequestMapping(method = RequestMethod.POST)
    public void sendSms(@RequestBody final SmsCode smsCode) {
        Integer code = new Random(System.currentTimeMillis()).nextInt((int) Math.pow(10, 6));
        smsCode.setCode(code.toString());
        String text = propertiesInstance().getSmsText().replaceFirst("&", code.toString());

//      Send SMS code and save it
        MultiValueMap requestParams = new LinkedMultiValueMap();
        requestParams.add(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_FORM_URLENCODED_VALUE);
        requestParams.add("apikey", propertiesInstance().getSmsApikey());
        requestParams.add("mobile", smsCode.getMobile());
        requestParams.add("text", text);

        String url = propertiesInstance().getSmsSendUrl();
        SmsCode result = new RestTemplate().postForObject(url, requestParams, SmsCode.class);

//      Remove SMS code after invalid since timeout
        if (0 == result.getReturnCode()) {
            smsCodeService.save(smsCode);

            taskScheduler.schedule(new Runnable() {
                @Override
                public void run() {
                    smsCodeService.delete(smsCode);
                }
            }, new Date(System.currentTimeMillis() + 10*60*1000));
        }
    }
}
