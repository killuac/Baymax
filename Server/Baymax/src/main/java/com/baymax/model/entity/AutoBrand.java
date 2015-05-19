package com.baymax.model.entity;

import javax.persistence.*;

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

    @Column(name = "brand_name")
    private String brandName;

    @Column(name = "logo_path")
    private String logoPath;

    @Column(name = "logo_file")
    private String logoFile;

    public short getBrandId() {
        return brandId;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getLogoPath() {
        return logoPath;
    }

    public void setLogoPath(String logoPath) {
        this.logoPath = logoPath;
    }

    public String getLogoFile() {
        return logoFile;
    }

    public void setLogoFile(String logoFile) {
        this.logoFile = logoFile;
    }
}
