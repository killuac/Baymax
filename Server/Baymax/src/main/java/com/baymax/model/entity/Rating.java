package com.baymax.model.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by Killua on 5/23/15.
 */

@Getter
@Setter
@Entity
@Table(name = "t_rating")
public class Rating {

    @Id
    @Column
    private int orderId;

    @Column
    private byte product;

    @Column
    private byte service;

    @Column
    private byte timeliness;

    @Column
    private String comment;
}
