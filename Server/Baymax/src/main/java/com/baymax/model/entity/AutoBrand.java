package com.baymax.model.entity;

import com.baymax.common.Constant;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Killua on 5/7/15.
 */

@Getter
@Setter
@Entity
@Table(name = "t_auto_brand")
public class AutoBrand {

    @Id
    @Column
    @GeneratedValue
    private short brandId;

    @Column
    private String brandName;

    @Column
    private String logoFilename;

    @Column
    private boolean obsolete;

    @OneToMany(mappedBy = "autoBrand", cascade = CascadeType.ALL)
    private List<AutoSeries> autoSerieses;

    public String getLogoFilename() {
        return Constant.IMG_LOGO_PATH + logoFilename;
    }
}
