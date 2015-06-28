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
@Table(name = "t_service")
public class Service {

    @Id
    @Column
    @GeneratedValue
    private short serviceId;

    @Column
    private String serviceName;

    @Column
    private double price;

    @Column
    private String imageName;

    @Column
    private String description;

    @Column
    private boolean obsolete;
}
