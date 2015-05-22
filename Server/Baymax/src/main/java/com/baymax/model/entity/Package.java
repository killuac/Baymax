package com.baymax.model.entity;

import javax.persistence.*;
import java.util.Set;

/**
 * Created by Killua on 5/22/15.
 */

@Entity
@Table(name = "t_package")
public class Package {

    @Id
    @Column(name = "package_id")
    @GeneratedValue
    private byte packageId;

    @Column(name = "package_name", nullable = false)
    private String packageName;

    @Column(name = "description", nullable = false)
    private String description;

    @OneToMany(mappedBy = "aPackage")
    private Set<PartsItem> partsItems;

    public byte getPackageId() {
        return packageId;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Set<PartsItem> getPartsItems() {
        return partsItems;
    }

    public void setPartsItems(Set<PartsItem> partsItems) {
        this.partsItems = partsItems;
    }
}
