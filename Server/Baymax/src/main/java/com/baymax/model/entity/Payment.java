package com.baymax.model.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

/**
 * Created by Killua on 5/24/15.
 */

@Getter
@Setter
@Entity
@Table(name = "t_payment")
public class Payment {

    @Id
    @Column
    @GeneratedValue
    private short paymentId;

    @Column
    private String paymentName;

    @Column
    private boolean obsolete;
}
