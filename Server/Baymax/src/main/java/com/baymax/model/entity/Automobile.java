package com.baymax.model.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.rest.core.annotation.RestResource;

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

    @RestResource(exported = false)
    @ManyToOne
    @JoinColumn(name = "modelId")
    private AutoModel autoModel;

    @RestResource(exported = false)
    @ManyToOne
    @JoinColumn(name = "userId")
    private User user;

    @OneToMany(mappedBy = "automobile")
    private List<Order> orders;

    @JsonIgnore
    public AutoModel getAutoModel() {
        return autoModel;
    }

    @JsonProperty
    public void setAutoModel(AutoModel autoModel) {
        this.autoModel = autoModel;
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

    public String getLogoFilename() {
        return autoModel.getAutoSeries().getAutoBrand().getLogoFilename();
    }

    @JsonIgnore
    public User getUser() {
        return user;
    }

    @JsonProperty
    public void setUser(User user) {
        this.user = user;
    }
}
