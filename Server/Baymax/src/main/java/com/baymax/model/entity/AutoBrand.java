package com.baymax.model.entity;

import javax.persistence.*;
import java.util.Set;

/**
 * Created by Killua on 5/7/15.
 */

@Entity
@Table(name = "t_auto_brand")
public class AutoBrand {

    @Id
    @Column(name = "brand_id")
    @GeneratedValue
    private short brandId;

    @Column(name = "brand_name", nullable = false)
    private String brandName;

    @Column(name = "logo_filename", nullable = false)
    private String logoFilename;

    @OneToMany(mappedBy = "autoBrand")
    private Set<AutoSeries> autoSerieses;

    public short getBrandId() {
        return brandId;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getLogoFilename() {
        return logoFilename;
    }

    public void setLogoFilename(String logoFilename) {
        this.logoFilename = logoFilename;
    }

    public Set<AutoSeries> getAutoSerieses() {
        return autoSerieses;
    }

    public void setAutoSerieses(Set<AutoSeries> autoSerieses) {
        this.autoSerieses = autoSerieses;
    }
}
