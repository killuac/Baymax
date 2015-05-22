package com.baymax.model.entity;

import javax.persistence.*;
import java.util.Set;

/**
 * Created by Killua on 5/22/15.
 */

@Entity
@Table(name = "t_parts")
public class Parts {

    @Id
    @Column(name = "parts_id")
    @GeneratedValue
    private byte partsId;

    @Column(name = "parts_name", nullable = false)
    private String partsName;

    @OneToMany(mappedBy = "parts")
    private Set<PartsBrand> partsBrands;

    public byte getPartsId() {
        return partsId;
    }

    public String getPartsName() {
        return partsName;
    }

    public void setPartsName(String partsName) {
        this.partsName = partsName;
    }

    public Set<PartsBrand> getPartsBrands() {
        return partsBrands;
    }

    public void setPartsBrands(Set<PartsBrand> partsBrands) {
        this.partsBrands = partsBrands;
    }
}
