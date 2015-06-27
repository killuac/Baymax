package com.baymax.model.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.rest.core.annotation.RestResource;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Killua on 5/22/15.
 */

@Getter
@Setter
@Entity
@Table(name = "t_auto_series")
public class AutoSeries{

    @Id
    @Column
    @GeneratedValue
    private short seriesId;

    @Column
    private String seriesName;

    @Column
    private boolean obsolete;

    @RestResource(exported = false)
    @ManyToOne
    @JoinColumn(name = "brandId")
    private AutoBrand autoBrand;

    @OneToMany(mappedBy = "autoSeries", cascade = CascadeType.ALL)
    private List<AutoModel> autoModels;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "seriesId")
    private List<AutoSeriesPartsItem> autoSeriesPartsItems;

    @JsonIgnore
    public AutoBrand getAutoBrand() {
        return autoBrand;
    }

    @JsonProperty
    public void setAutoBrand(AutoBrand autoBrand) {
        this.autoBrand = autoBrand;
    }
}
