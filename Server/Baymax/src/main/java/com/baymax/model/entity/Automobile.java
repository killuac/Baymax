package com.baymax.model.entity;

import javax.persistence.*;

/**
 * Created by Killua on 5/8/15.
 */

@Entity
@Table(name = "t_automobile")
public class Automobile {

    @Id
    @Column(name = "automobile_id")
    @GeneratedValue
    private short automobileId;
}
