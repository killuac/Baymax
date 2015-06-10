package com.baymax.model.entity;

import com.baymax.common.Constant;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.rest.core.annotation.RestResource;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Killua on 5/7/15.
 */

@Getter
@Setter
@Entity
@Table(name = "t_auto_brand")
public class AutoBrand {

    @Id
    @Column
    @GeneratedValue
    private short brandId;

    @Column
    private String brandName;

    @Column
    private String logoName;

    @Column
    private boolean obsolete;

    @OneToMany(mappedBy = "autoBrand", cascade = CascadeType.ALL)
    private List<AutoSeries> autoSerieses;

    @JsonIgnore
    public String getLogoName() {
        return logoName;
    }

    @JsonProperty
    public void setLogoName(String logoName) {
        this.logoName = logoName;
    }

    public String getLogoURL() {
        return Constant.IMG_LOGO_PATH + logoName;
    }
}
