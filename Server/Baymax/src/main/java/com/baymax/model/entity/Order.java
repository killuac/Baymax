package com.baymax.model.entity;

import javax.persistence.*;

/**
 * Created by Killua on 5/8/15.
 */

@Entity
@Table(name = "t_order")
public class Order {

    @Id
    @Column(name = "order_id")
    @GeneratedValue
    private short orderId;
}
