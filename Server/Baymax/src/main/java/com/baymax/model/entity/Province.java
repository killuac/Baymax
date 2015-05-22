package com.baymax.model.entity;

import javax.persistence.*;
import java.util.Set;

/**
 * Created by Killua on 5/22/15.
 */

@Entity
@Table(name = "t_province")
public class Province {

    @Id
    @Column(name = "province_id")
    @GeneratedValue
    private byte provinceId;

    @Column(name = "province_name", nullable = false)
    private String provinceName;

    @Column(name = "abbreviation", nullable = false)
    private String abbreviation;

    @Column(name = "is_opened")
    private boolean isOpened;

    @OneToMany(mappedBy = "province")
    private Set<City> cities;

    public byte getProvinceId() {
        return provinceId;
    }

    public String getProvinceName() {
        return provinceName;
    }

    public void setProvinceName(String provinceName) {
        this.provinceName = provinceName;
    }

    public String getAbbreviation() {
        return abbreviation;
    }

    public void setAbbreviation(String abbreviation) {
        this.abbreviation = abbreviation;
    }

    public boolean isOpened() {
        return isOpened;
    }

    public void setIsOpened(boolean isOpened) {
        this.isOpened = isOpened;
    }

    public Set<City> getCities() {
        return cities;
    }

    public void setCities(Set<City> cities) {
        this.cities = cities;
    }
}
