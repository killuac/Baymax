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
@Table(name = "t_city")
public class City {

    @Id
    @Column
    @GeneratedValue
    private short cityId;

    @Column
    private byte provinceId;

    @Column
    private String cityName;

    @Column
    private boolean opened;

    @ManyToOne
    @JoinColumn(name = "provinceId", insertable = false, updatable = false)
    private Province province;

    @OneToMany(mappedBy = "city", cascade = CascadeType.ALL)
    @Where(clause = "opened = '1'")
    private List<District> districts;
}
