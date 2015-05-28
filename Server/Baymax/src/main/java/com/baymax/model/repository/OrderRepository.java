package com.baymax.model.repository;

import com.baymax.model.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RestResource;

import java.util.List;

/**
 * Created by Killua on 5/8/15.
 */
public interface OrderRepository extends JpaRepository<Order, Integer> {

    @Query("select o from Order o inner join o.automobile a inner join a.user u where u.userId = :userId")
    List<Order> findByUserId(@Param("userId") int userId);

    @Override
    @RestResource(exported = false)
    Order save(Order entity);

    @Override
    @RestResource(exported = false)
    void delete(Integer id);

    @Override
    @RestResource(exported = false)
    void delete(Order entity);
}
