package com.baymax.model.entity;

import com.baymax.common.Constant;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

/**
 * Created by Killua on 5/22/15.
 */

@Getter
@Setter
@Entity
@Table(name = "t_parts_item")
public class PartsItem {

    @Id
    @Column
    @GeneratedValue
    private short itemId;

    @Column
    private byte partsId;

    @Column
    private String brandName;

    @Column
    private double price;

    @Column
    private double fourLiterPrice;

    @Column
    private String description;

    @Column
    private String imageFilename;

    @Column
    private boolean obsolete;

    @ManyToOne
    @JoinColumn(name = "partsId", insertable = false, updatable = false)
    private Parts parts;

    public String getImageFilename() {
        return Constant.IMG_PARTS_PATH + imageFilename;
    }
}
