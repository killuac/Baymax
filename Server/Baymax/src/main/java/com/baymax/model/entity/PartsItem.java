package com.baymax.model.entity;

import javax.persistence.*;
import java.util.Set;

/**
 * Created by Killua on 5/22/15.
 */

@Entity
@Table(name = "t_parts_item")
public class PartsItem {

    @Id
    @Column(name = "item_id")
    @GeneratedValue
    private byte itemId;

    @Column(name = "weight", nullable = false)
    private byte weight;

    @Column(name = "price", nullable = false)
    private double price;

    @Column(name = "image_filename", nullable = false)
    private String imageFilename;

    @ManyToOne(optional = false)
    @JoinColumn(name = "brand_id", nullable = false)
    private PartsBrand partsBrand;

    @ManyToOne(optional = false)
    @JoinColumn(name = "package_id", nullable = false)
    private Package aPackage;

    @OneToMany(mappedBy = "partsItem")
    private Set<OrderItem> orderItems;

    public byte getItemId() {
        return itemId;
    }

    public byte getWeight() {
        return weight;
    }

    public void setWeight(byte weight) {
        this.weight = weight;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImageFilename() {
        return imageFilename;
    }

    public void setImageFilename(String imageFilename) {
        this.imageFilename = imageFilename;
    }

    public PartsBrand getPartsBrand() {
        return partsBrand;
    }

    public void setPartsBrand(PartsBrand partsBrand) {
        this.partsBrand = partsBrand;
    }

    public Package getaPackage() {
        return aPackage;
    }

    public void setaPackage(Package aPackage) {
        this.aPackage = aPackage;
    }

    public Set<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(Set<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }
}
