package com.baymax.model.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Set;

/**
 * Created by Killua on 5/22/15.
 */

@Entity
@Table(name = "t_employee")
public class Employee {

    @Id
    @Column(name = "employee_id")
    private String employeeId;

    @Column(name = "employee_name")
    private String employeeName;

    @Column(name = "password", nullable = false)
    @JsonIgnore
    private String password;

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

    @OneToMany(mappedBy = "employee")
    private Set<Order> employeeOrders;

    @OneToMany(mappedBy = "coworker")
    private Set<Order> coworkerOrders;


    public String getEmployeeId() {
        return employeeId;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
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

    public boolean isWrongPassword() {
        return isWrongPassword;
    }

    public void setIsWrongPassword(boolean isWrongPassword) {
        this.isWrongPassword = isWrongPassword;
    }

    public Set<Order> getEmployeeOrders() {
        return employeeOrders;
    }

    public void setEmployeeOrders(Set<Order> employeeOrders) {
        this.employeeOrders = employeeOrders;
    }

    public Set<Order> getCoworkerOrders() {
        return coworkerOrders;
    }

    public void setCoworkerOrders(Set<Order> coworkerOrders) {
        this.coworkerOrders = coworkerOrders;
    }
}
