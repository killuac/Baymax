package com.baymax.model.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.List;

/**
 * Created by Killua on 5/8/15.
 */

@Getter
@Setter
@Entity
@Table(name = "t_automobile")
public class Automobile {

    @Id
    @Column
    @GeneratedValue
    private int automobileId;

    @Column
    private int userId;

    @Column
    private short modelId;

    @Column
    private String registrationPlate;

    @Column
    private String vinNumber;

    @Column
    private int mileage;

    @Column
    private byte maintenanceCount;

    @Column
    private boolean obsolete;

    @Column
    private Timestamp createTime;

    @ManyToOne
    @JoinColumn(name = "modelId", insertable = false, updatable = false)
    private AutoModel autoModel;

    @ManyToOne
    @JoinColumn(name = "userId", insertable = false, updatable = false)
    private User user;

    @OneToMany(mappedBy = "automobile")
    private List<Order> orders;

    public void setRegistrationPlate(String registrationPlate) {
        this.registrationPlate = registrationPlate.toUpperCase();
    }

    public String getBrandName() {
        return autoModel.getAutoSeries().getAutoBrand().getBrandName();
    }

    public String getSeriesName() {
        return autoModel.getAutoSeries().getSeriesName();
    }

    public String getModelName() {
        return autoModel.getModelName();
    }

    public byte getOilCapacity() {
        return autoModel.getOilCapacity();
    }

    public String getLogoName() {
        return autoModel.getAutoSeries().getAutoBrand().getLogoName();
    }
}
