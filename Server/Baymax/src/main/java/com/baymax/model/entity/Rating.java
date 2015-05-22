package com.baymax.model.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by Killua on 5/23/15.
 */

@Entity
@Table(name = "t_rating")
public class Rating {

    @Id
    @Column(name = "order_id")
    private int orderId;

    @Column(name = "product")
    private byte product;

    @Column(name = "service")
    private byte service;

    @Column(name = "timeliness")
    private byte timeliness;

    @Column(name = "comment")
    private String comment;

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public byte getProduct() {
        return product;
    }

    public void setProduct(byte product) {
        this.product = product;
    }

    public byte getService() {
        return service;
    }

    public void setService(byte service) {
        this.service = service;
    }

    public byte getTimeliness() {
        return timeliness;
    }

    public void setTimeliness(byte timeliness) {
        this.timeliness = timeliness;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
}
