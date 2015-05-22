package com.baymax.model.entity;

import javax.persistence.*;

/**
 * Created by Killua on 5/22/15.
 */

@Entity
@Table(name = "t_order_status")
public class OrderStatus {

    @Id
    @Column(name = "status_id")
    @GeneratedValue
    private byte statusId;

    @Column(name = "status_name")
    private String statusName;

    public byte getStatusId() {
        return statusId;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }
}
