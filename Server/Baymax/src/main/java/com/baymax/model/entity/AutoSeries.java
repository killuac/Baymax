package com.baymax.model.entity;

import javax.persistence.*;
import java.util.Set;

/**
 * Created by Killua on 5/22/15.
 */

@Entity
@Table(name = "t_auto_series")
public class AutoSeries {

    @Id
    @Column(name = "series_id")
    @GeneratedValue
    private short seriesId;

    @Column(name = "series_name")
    private String seriesName;

    @ManyToOne(optional = false)
    @JoinColumn(name = "brand_id", nullable = false)
    private AutoBrand autoBrand;

    @OneToMany(mappedBy = "autoSeries")
    private Set<AutoModel> autoModels;

    public short getSeriesId() {
        return seriesId;
    }

    public String getSeriesName() {
        return seriesName;
    }

    public void setSeriesName(String seriesName) {
        this.seriesName = seriesName;
    }

    public AutoBrand getAutoBrand() {
        return autoBrand;
    }

    public void setAutoBrand(AutoBrand autoBrand) {
        this.autoBrand = autoBrand;
    }

    public Set<AutoModel> getAutoModels() {
        return autoModels;
    }

    public void setAutoModels(Set<AutoModel> autoModels) {
        this.autoModels = autoModels;
    }
}
