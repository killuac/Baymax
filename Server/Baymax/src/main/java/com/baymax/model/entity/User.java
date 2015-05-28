package com.baymax.model.entity;

import com.baymax.common.Constant;
import com.baymax.common.Util;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.List;
import java.util.Random;

/**
 * Created by Killua on 4/29/15.
 */

@Getter
@Setter
@Entity
@Table(name = "t_user")
public class User {

    @Id
    @Column
    @GeneratedValue
    private int userId;

    @Column
    private String password;

    @Column
    private String userName;

    @Column
    private String realName;

    @Column
    private String mobile;

    @Column
    private String email;

    @Column
    private boolean obsolete;

    @Column
    private Timestamp createTime;

    @Column
    private String avatarFilename;

    @Transient
    private boolean wrongPassword;

    @OneToMany(mappedBy = "user")
    @Where(clause = "obsolete = '0'")
    private List<Automobile> automobiles;

    @OneToMany(mappedBy = "user")
    @Where(clause = "obsolete = '0'")
    private List<Address> addresses;


    public User() {}
    public User(String mobile, String password) {
        this.mobile = mobile;
        this.password = password;
    }

    @JsonIgnore
    public String getPassword() {
        return password;
    }

    @JsonProperty
    public void setPassword(String password) {
        this.password = Util.generateHashedPassword(password);
    }

    public void setUserName(String userName) {
        this.userName = (null != userName && "" != userName) ? userName : randomAnUserName();
    }

    public String randomAnUserName() {
        return Constant.PREFIX_RANDOM_USER +
                (long)(new Random(Long.parseLong(mobile)).nextDouble()*Math.pow(10, 16));
    }

    public String getAvatarFilename() {
        return (null != avatarFilename) ? Constant.IMG_AVATAR_PATH + avatarFilename : avatarFilename;
    }
}
