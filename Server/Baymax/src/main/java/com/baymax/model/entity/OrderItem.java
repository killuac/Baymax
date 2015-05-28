package com.baymax.model.entity;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

/**
 * Created by Killua on 5/22/15.
 */

@Getter
@Setter
@Entity
@Table(name = "t_order_item")
//@JsonIdentityInfo(property = "itemId", generator=ObjectIdGenerators.PropertyGenerator.class)
public class OrderItem {

    @Id
    @Column
    @GeneratedValue
    private int itemId;

    @Column
    private int orderId;

    @Column
    private Byte partsItemId;   // Maybe null, so use Byte object

    @Column
    private Byte serviceId;

    @Column
    private byte quantity;

    @Column
    private double price;   // Assign it after partsItems assignment

    @ManyToOne
    @JoinColumn(name = "orderId", insertable = false, updatable = false)
    private Order order;

    @ManyToOne
    @JoinColumn(name = "partsItemId", insertable = false, updatable = false)
    private PartsItem partsItem;

    @ManyToOne
    @JoinColumn(name = "serviceId", insertable = false, updatable = false)
    private Service service;


    public void setPrice(double price) {
        this.price = (null != partsItem) ? partsItem.getPrice() : service.getPrice();

        double fourLiterPrice = partsItem.getFourLiterPrice();
        if (null != partsItem && fourLiterPrice > 0) {
            int oilCapacity = order.getAutomobile().getOilCapacity();
            this.price = (oilCapacity/4) * fourLiterPrice + (oilCapacity%4) * this.price;
        }
    }

    public String getItemName() {
        return (null != partsItem) ? partsItem.getBrandName() : service.getServiceName();
    }

    public String getDescription() {
        return (null != partsItem) ? partsItem.getDescription() : service.getDescription();
    }
}
