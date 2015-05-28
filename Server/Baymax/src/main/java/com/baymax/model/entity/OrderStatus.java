package com.baymax.model.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

/**
 * Created by Killua on 5/22/15.
 */

@Getter
@Setter
@Entity
@Table(name = "t_order_status")
public class OrderStatus {

    @Id
    @Column
    @GeneratedValue
    private short statusId;

    @Column
    private String statusName;
}
