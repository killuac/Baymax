package com.baymax.model.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.List;

/**
 * Created by Killua on 5/8/15.
 */

@Getter
@Setter
@Entity
@Table(name = "t_order")
//@JsonIdentityInfo(property = "orderId", generator=ObjectIdGenerators.PropertyGenerator.class)
public class Order {

    @Id
    @Column
    @GeneratedValue
    private int orderId;

    @Column
    private int automobileId;

    @Column
    private byte statusId;

    @Column
    private byte paymentId;

    @Column
    private int addressId;

    @Column
    private String employeeId;

    @Column
    private String coworkerId;

    @Column
    private boolean ownParts;

    @Column
    private boolean needInvoice;

    @Column
    private double amount;

    @Column
    private Timestamp serviceTime;

    @Column
    private Timestamp createTime;

    @Column
    private Timestamp acceptTime;

    @Column
    private Timestamp completeTime;

    @Column
    private String remark;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
    private List<OrderItem> orderItems;

    @ManyToOne
    @JoinColumn(name = "automobileId", insertable = false, updatable = false)
    private Automobile automobile;

    @ManyToOne
    @JoinColumn(name = "statusId", insertable = false, updatable = false)
    private OrderStatus orderStatus;

    @ManyToOne
    @JoinColumn(name = "paymentId", insertable = false, updatable = false)
    private Payment payment;

    @ManyToOne
    @JoinColumn(name = "addressId", insertable = false, updatable = false)
    private Address address;

    @ManyToOne
    @JoinColumn(name = "employeeId", insertable = false, updatable = false)
    private Employee employee;

    @ManyToOne
    @JoinColumn(name = "coworkerId", insertable = false, updatable = false)
    private Employee coworker;

    @OneToOne
    @PrimaryKeyJoinColumn(name = "orderId")
    private Rating rating;


    public String getAutoLogoName() {
        return automobile.getLogoName();
    }

    public String getStatusName() {
        return orderStatus.getStatusName();
    }

    public String getPaymentName() {
        return payment.getPaymentName();
    }

    public String getDetailAddress() {
        return address.getDetailAddress();
    }

    public void setAmount(double amount) {
        if (null == orderItems) return;

        amount = 0;
        for (OrderItem orderItem : orderItems) {
            amount += orderItem.getPrice();
        }
        this.amount = amount;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
        this.setAmount(0);
    }
}
