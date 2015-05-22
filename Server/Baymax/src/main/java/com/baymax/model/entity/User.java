package com.baymax.model.entity;

import com.baymax.common.Util;
import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Set;

/**
 * Created by Killua on 4/29/15.
 */

@Entity
@Table(name = "t_user")
public class User {

    @Id
    @Column(name = "user_id")
    @GeneratedValue
    private int userId;

    @Column(name = "user_name", unique = true, nullable = false)
    private String userName;

    @Column(name = "password", nullable = false)
    @JsonIgnore
    private String password;

    @Column(name = "real_name")
    private String realName;

    @Column(name = "mobile", unique = true, nullable = false, length = 11)
    private String mobile;

    @Column(name = "email", unique = true)
    private String email;

    @Column(name = "is_obsolete")
    private boolean isObsolete;

    @Column(name = "create_time")
    private Timestamp createTime;

    @Transient
    private boolean isWrongPassword;

    @OneToMany(mappedBy = "user")
    private Set<Automobile> automobiles;

    @OneToMany(mappedBy = "user")
    private Set<Address> addresses;


    public int getUserId() {
        return userId;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = Util.generateHashedPassword(password);
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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

    public Set<Automobile> getAutomobiles() {
        return automobiles;
    }

    public void setAutomobiles(Set<Automobile> automobiles) {
        this.automobiles = automobiles;
    }

    public boolean isWrongPassword() {
        return isWrongPassword;
    }

    public void setIsWrongPassword(boolean isWrongPassword) {
        this.isWrongPassword = isWrongPassword;
    }
}