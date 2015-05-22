package com.baymax.model.entity;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Set;

/**
 * Created by Killua on 5/8/15.
 */

@Entity
@Table(name = "t_automobile")
public class Automobile {

    @Id
    @Column(name = "automobile_id")
    @GeneratedValue
    private short automobileId;

    @Column(name = "registration_plate", unique = true, nullable = false, length = 7)
    private String registrationPlate;

    @Column(name = "vin_number", unique = true, length = 17)
    private String vinNumber;

    @Column(name = "mileage")
    private int mileage;

    @Column(name = "maintenance_count")
    private byte maintenanceCount;

    @Column(name = "is_obsolete")
    private boolean isObsolete;

    @Column(name = "create_time")
    private Timestamp createTime;

    @ManyToOne(optional = false)
    @JoinColumn(name = "model_id", nullable = false)
    private AutoModel autoModel;

    @ManyToOne(optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @OneToMany(mappedBy = "automobile")
    private Set<Order> orders;

    public short getAutomobileId() {
        return automobileId;
    }

    public String getRegistrationPlate() {
        return registrationPlate;
    }

    public void setRegistrationPlate(String registrationPlate) {
        this.registrationPlate = registrationPlate;
    }

    public String getVinNumber() {
        return vinNumber;
    }

    public void setVinNumber(String vinNumber) {
        this.vinNumber = vinNumber;
    }

    public int getMileage() {
        return mileage;
    }

    public void setMileage(int mileage) {
        this.mileage = mileage;
    }

    public byte getMaintenanceCount() {
        return maintenanceCount;
    }

    public void setMaintenanceCount(byte maintenanceCount) {
        this.maintenanceCount = maintenanceCount;
    }

    public boolean isObsolete() {
        return isObsolete;
    }

    public void setIsObsolete(boolean isObsolete) {
        this.isObsolete = isObsolete;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public AutoModel getAutoModel() {
        return autoModel;
    }

    public void setAutoModel(AutoModel autoModel) {
        this.autoModel = autoModel;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Set<Order> getOrders() {
        return orders;
    }

    public void setOrders(Set<Order> orders) {
        this.orders = orders;
    }
}
