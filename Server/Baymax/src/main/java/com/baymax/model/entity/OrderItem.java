package com.baymax.model.entity;

import javax.persistence.*;

/**
 * Created by Killua on 5/22/15.
 */

@Entity
@Table(name = "t_order_item")
public class OrderItem {

    @Id
    @Column(name = "item_id")
    @GeneratedValue
    private int itemId;

    @Column(name = "quantity")
    private byte quantity;

    @ManyToOne(optional = false)
    @JoinColumn(name = "order_id", nullable = false)
    private Order order;

    @ManyToOne
    @JoinColumn(name = "parts_item_id")
    private PartsItem partsItem;

    @ManyToOne
    @JoinColumn(name = "service_id")
    private Service service;

    public int getItemId() {
        return itemId;
    }

    public byte getQuantity() {
        return quantity;
    }

    public void setQuantity(byte quantity) {
        this.quantity = quantity;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public PartsItem getPartsItem() {
        return partsItem;
    }

    public void setPartsItem(PartsItem partsItem) {
        this.partsItem = partsItem;
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }
}
