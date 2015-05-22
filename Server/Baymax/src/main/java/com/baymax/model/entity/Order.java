package com.baymax.model.entity;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Set;

/**
 * Created by Killua on 5/8/15.
 */

@Entity
@Table(name = "t_order")
public class Order {

    @Id
    @Column(name = "order_id")
    @GeneratedValue
    private int orderId;

    @Column(name = "service_time")
    private Timestamp serviceTime;

    @Column(name = "create_time")
    private Timestamp createTime;

    @Column(name = "accept_time")
    private Timestamp acceptTime;

    @Column(name = "complete_time")
    private Timestamp completeTime;

    @Column(name = "description")
    private String description;

    @ManyToOne(optional = false)
    @JoinColumn(name = "automobile_id", nullable = false)
    private Automobile automobile;

    @ManyToOne(optional = false)
    @JoinColumn(name = "status_id", nullable = false)
    private OrderStatus orderStatus;

    @OneToMany(mappedBy = "order")
    private Set<OrderItem> orderItems;

    @ManyToOne
    @JoinColumn(name = "employee_id")
    private Employee employee;

    @ManyToOne
    @JoinColumn(name = "coworker_id")
    private Employee coworker;

    @OneToOne(optional = false)
    @PrimaryKeyJoinColumn(name = "order_id")
    private Rating rating;

    public int getOrderId() {
        return orderId;
    }

    public Timestamp getServiceTime() {
        return serviceTime;
    }

    public void setServiceTime(Timestamp serviceTime) {
        this.serviceTime = serviceTime;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public Timestamp getAcceptTime() {
        return acceptTime;
    }

    public void setAcceptTime(Timestamp acceptTime) {
        this.acceptTime = acceptTime;
    }

    public Timestamp getCompleteTime() {
        return completeTime;
    }

    public void setCompleteTime(Timestamp completeTime) {
        this.completeTime = completeTime;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Automobile getAutomobile() {
        return automobile;
    }

    public void setAutomobile(Automobile automobile) {
        this.automobile = automobile;
    }

    public OrderStatus getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(OrderStatus orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Set<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(Set<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public Employee getCoworker() {
        return coworker;
    }

    public void setCoworker(Employee coworker) {
        this.coworker = coworker;
    }

    public Rating getRating() {
        return rating;
    }

    public void setRating(Rating rating) {
        this.rating = rating;
    }
}
