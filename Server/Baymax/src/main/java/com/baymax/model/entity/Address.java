package com.baymax.model.entity;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by Killua on 5/22/15.
 */

@Entity
@Table(name = "t_address")
public class Address {

    @Id
    @Column(name = "address_id")
    @GeneratedValue
    private int addressId;

    @Column(name = "detail_address", nullable = false)
    private String detailAddress;

    @Column(name = "is_obsolete")
    private boolean isObsolete;

    @Column(name = "create_time")
    private Timestamp createTime;

    @ManyToOne(optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(optional = false)
    @JoinColumn(name = "district_id", nullable = false)
    private District district;

    public int getAddressId() {
        return addressId;
    }

    public String getDetailAddress() {
        return detailAddress;
    }

    public void setDetailAddress(String detailAddress) {
        this.detailAddress = detailAddress;
    }

    public boolean isObsolete() {
        return isObsolete;
    }

    public void setIsObsolete(boolean isObsolete) {
        this.isObsolete = isObsolete;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public District getDistrict() {
        return district;
    }

    public void setDistrict(District district) {
        this.district = district;
    }
}
