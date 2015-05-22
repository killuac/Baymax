package com.baymax.model.entity;

import javax.persistence.*;
import java.util.Set;

/**
 * Created by Killua on 5/22/15.
 */

@Table(name = "t_auto_model")
public class AutoModel {

    @Id
    @Column(name = "model_id")
    @GeneratedValue
    private short modelId;

    @Column(name = "model_name")
    private String modelName;

    @ManyToOne(optional = false)
    @JoinColumn(name = "series_id", nullable = false)
    private AutoSeries autoSeries;

    @OneToMany(mappedBy = "AutoModel")
    private Set<Automobile> automobiles;

    public short getModelId() {
        return modelId;
    }

    public String getModelName() {
        return modelName;
    }

    public void setModelName(String modelName) {
        this.modelName = modelName;
    }

    public AutoSeries getAutoSeries() {
        return autoSeries;
    }

    public void setAutoSeries(AutoSeries autoSeries) {
        this.autoSeries = autoSeries;
    }

    public Set<Automobile> getAutomobiles() {
        return automobiles;
    }

    public void setAutomobiles(Set<Automobile> automobiles) {
        this.automobiles = automobiles;
    }
}
