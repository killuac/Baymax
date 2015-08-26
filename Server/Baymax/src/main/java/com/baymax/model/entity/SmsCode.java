package com.baymax.model.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Random;

/**
 * Created by Killua on 7/11/15.
 */

@Getter
@Setter
@Entity
@Table(name = "t_sms_code")
public class SmsCode {

    @Id
    @Column
    private String mobile;

    @Column
    private String code;

    @Transient
    private short returnCode;
}
