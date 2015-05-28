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
@Table(name = "t_district")
public class District {

    @Id
    @Column
    @GeneratedValue
    private short districtId;

    @Column
    private short cityId;

    @Column
    private String districtName;

    @Column
    private boolean opened;

    @ManyToOne
    @JoinColumn(name = "cityId", insertable = false, updatable = false)
    private City city;
}
