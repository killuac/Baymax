package com.baymax.model.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by Killua on 5/22/15.
 */

@Getter
@Setter
@Entity
@Table(name = "t_address")
public class Address {

    @Id
    @Column
    @GeneratedValue
    private int addressId;

    @Column
    private short districtId;

    @Column
    private int userId;

    @Column
    private String mobile;

    @Column
    private String realName;

    @Column
    private String detailAddress;

    @Column
    private boolean obsolete;

    @Column
    private Timestamp createTime;

    @ManyToOne
    @JoinColumn(name = "districtId", insertable = false, updatable = false)
    private District district;

    @ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "userId", insertable = false, updatable = false)
    private User user;


    public void setRealName(String realName) {
        this.realName = realName;
        if (null == user.getRealName() || "" == user.getRealName()) {
            user.setRealName(realName);
        }
    }

    public String getDetailAddress() {
        return district.getCity().getCityName() + " " +
                district.getDistrictName() + " " + detailAddress;
    }
}
