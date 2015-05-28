package com.baymax.model.entity;

import com.baymax.common.Util;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.List;

/**
 * Created by Killua on 5/22/15.
 */

@Getter
@Setter
@Entity
@Table(name = "t_employee")
public class Employee {

    @Id
    @Column
    private String employeeId;

    @Column
    private String employeeName;

    @Column
    private String password;

    @Column
    private String mobile;

    @Column
    private String email;

    @Column
    private boolean obsolete;

    @Column
    private Timestamp createTime;

    @Transient
    private boolean wrongPassword;

    @OneToMany(mappedBy = "employee")
    private List<Order> employeeOrders;

    @OneToMany(mappedBy = "coworker")
    private List<Order> coworkerOrders;

    @JsonIgnore
    public String getPassword() {
        return password;
    }

    @JsonProperty
    public void setPassword(String password) {
        this.password = Util.generateHashedPassword(password);
    }
}
