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
@Table(name = "t_province")
public class Province {

    @Id
    @Column
    @GeneratedValue
    private short provinceId;

    @Column
    private String provinceName;

    @Column
    private String abbreviation;

    @Column
    private boolean opened;

    @OneToMany(mappedBy = "province", cascade = CascadeType.ALL)
    @Where(clause = "opened = '0'")
    private List<City> cities;
}
