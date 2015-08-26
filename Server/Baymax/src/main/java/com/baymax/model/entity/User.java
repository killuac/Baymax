package com.baymax.model.entity;

import com.baymax.common.Constant;
import com.baymax.common.Util;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Where;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.hateoas.Identifiable;

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
public class User implements Identifiable<Integer> {    // For creating resource link

    @JsonIgnore
    @Override
    public Integer getId() {
        return userId;
    }

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
    private String areaName;

    @Column
    private boolean obsolete;

    @Column
    private Timestamp createTime;

    @Column
    private String avatarName;

    @Transient
    private boolean notFound;

    @Transient
    private boolean mobileTaken;

    @Transient
    private boolean wrongPassword;

    @Transient
    private boolean wrongVcode;

    @OneToMany(mappedBy = "user")
    @Where(clause = "obsolete = '0'")
    private List<Automobile> automobiles;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    @Where(clause = "obsolete = '0'")
    private List<Address> addresses;

    public User() {}
    public User(String mobile, String password) {
        this.mobile = mobile;
        this.password = Util.generateHashedPassword(password);
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
        this.userName = (null != userName && !userName.isEmpty()) ? userName : randomAnUserName();
    }

    private final static Logger logger = LoggerFactory.getLogger(User.class);

    public String randomAnUserName() {
        return Constant.PREFIX_RANDOM_USER +
                (long)(new Random(Long.parseLong(mobile)).nextDouble()*Math.pow(10, 16));
    }
}
