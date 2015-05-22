package com.baymax.model.entity;

import javax.persistence.*;
import java.util.Set;

/**
 * Created by Killua on 5/22/15.
 */

@Entity
@Table(name = "t_parts_brand")
public class PartsBrand {

    @Id
    @Column(name = "brand_id")
    @GeneratedValue
    private byte brandId;

    @Column(name = "brand_name", nullable = false)
    private String brandName;

    @Column(name = "description", nullable = false)
    private String description;

    @ManyToOne
    @JoinColumn(name = "parts_id", nullable = false)
    private Parts parts;

    @OneToMany(mappedBy = "partsBrand")
    private Set<PartsItem> partsItems;

    public byte getBrandId() {
        return brandId;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Parts getParts() {
        return parts;
    }

    public void setParts(Parts parts) {
        this.parts = parts;
    }

    public Set<PartsItem> getPartsItems() {
        return partsItems;
    }

    public void setPartsItems(Set<PartsItem> partsItems) {
        this.partsItems = partsItems;
    }
}
