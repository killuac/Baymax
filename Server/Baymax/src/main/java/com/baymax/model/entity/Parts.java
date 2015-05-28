package com.baymax.model.entity;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Killua on 5/22/15.
 */

@Getter
@Setter
@Entity
@Table(name = "t_parts")
public class Parts {

    @Id
    @Column
    @GeneratedValue
    private short partsId;

    @Column
    private String partsName;

    @Column
    private boolean obsolete;

    @OneToMany(mappedBy = "parts", cascade = CascadeType.ALL)
    @Where(clause = "obsolete = '0'")
    private List<PartsItem> partsItems;
}
