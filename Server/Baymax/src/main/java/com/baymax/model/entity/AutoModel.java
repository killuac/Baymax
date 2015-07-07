package com.baymax.model.entity;

import lombok.*;

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
    private short seriesId;

    @Column
    private String modelName;

    @Column
    private byte oilCapacity;

    @Column
    private boolean obsolete;

    @ManyToOne
    @JoinColumn(name = "seriesId", insertable = false, updatable = false)
    private AutoSeries autoSeries;
}
