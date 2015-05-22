package com.baymax.model.entity;

import javax.persistence.*;
import java.util.Set;

/**
 * Created by Killua on 5/22/15.
 */

@Entity
@Table(name = "t_district")
public class District {

    @Id
    @Column(name = "district_id")
    @GeneratedValue
    private short districtId;

    @Column(name = "district_name", nullable = false)
    private String districtName;

    @Column(name = "is_opened")
    private boolean isOpened;

    @ManyToOne(optional = false)
    @JoinColumn(name = "city_id", nullable = false)
    private City city;

    @OneToMany(mappedBy = "district")
    private Set<Address> addresses;

    public short getDistrictId() {
        return districtId;
    }

    public String getDistrictName() {
        return districtName;
    }

    public void setDistrictName(String districtName) {
        this.districtName = districtName;
    }

    public boolean isOpened() {
        return isOpened;
    }

    public void setIsOpened(boolean isOpened) {
        this.isOpened = isOpened;
    }

    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }

    public Set<Address> getAddresses() {
        return addresses;
    }

    public void setAddresses(Set<Address> addresses) {
        this.addresses = addresses;
    }
}
