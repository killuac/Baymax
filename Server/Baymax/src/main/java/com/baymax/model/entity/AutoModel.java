package com.baymax.model.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import org.springframework.data.rest.core.annotation.RestResource;

import javax.persistence.*;

/**
 * Created by Killua on 5/22/15.
 */

@Getter
@Setter
@Entity
@Table(name = "t_auto_model")
public class AutoModel {

    @Id
    @Column
    @GeneratedValue
    private short modelId;

    @Column
    private String modelName;

    @Column
    private byte oilCapacity;

    @Column
    private boolean obsolete;

    @RestResource(exported = false)
    @ManyToOne
    @JoinColumn(name = "seriesId")
    private AutoSeries autoSeries;

    @JsonIgnore
    public AutoSeries getAutoSeries() {
        return autoSeries;
    }

    @JsonProperty
    public void setAutoSeries(AutoSeries autoSeries) {
        this.autoSeries = autoSeries;
    }
}
