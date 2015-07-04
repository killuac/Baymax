package com.baymax.model.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.rest.core.annotation.RestResource;

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
    private byte quantity;

    @Column
    private double price;

    @ManyToOne
    @JoinColumn(name = "orderId", insertable = false, updatable = false)
//    @MapsId
    private Order order;

    @RestResource(exported = false)
    @ManyToOne
    @JoinColumn(name = "partsItemId")
    private PartsItem partsItem;

    @RestResource(exported = false)
    @ManyToOne
    @JoinColumn(name = "serviceId")
    private Service service;

    public void setPrice(double price) {
        if (null != partsItem) {
            price = partsItem.getPrice();

            double fourLiterPrice = partsItem.getFourLiterPrice();
            if (null != partsItem && fourLiterPrice > 0) {
                int oilCapacity = order.getAutomobile().getOilCapacity();
                price = (oilCapacity/4) * fourLiterPrice + (oilCapacity%4) * this.price;
            }
        } else {
            price = service.getPrice();
        }

        this.price = price;
    }

    public String getItemName() {
        return (null != partsItem) ? partsItem.getBrandName() : service.getServiceName();
    }

    public String getItemDescription() {
        return (null != partsItem) ? partsItem.getDescription() : service.getDescription();
    }

    @JsonIgnore
    public PartsItem getPartsItem() {
        return partsItem;
    }

    @JsonProperty
    public void setPartsItem(PartsItem partsItem) {
        this.partsItem = partsItem;
        this.setPrice(partsItem.getPrice());
    }

    @JsonIgnore
    public Service getService() {
        return service;
    }

    @JsonProperty
    public void setService(Service service) {
        this.service = service;
        this.setPrice(service.getPrice());
    }
}
