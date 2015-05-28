package com.baymax.model.repository;

import com.baymax.model.entity.OrderItem;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.rest.core.annotation.RestResource;

/**
 * Created by Killua on 5/24/15.
 */
//@RepositoryRestResource(excerptProjection = OrderDetailProjection.class)
public interface OrderItemRepository extends CrudRepository<OrderItem, Integer> {

    @Override
    @RestResource(exported = false)
    OrderItem save(OrderItem entity);

    @Override
    @RestResource(exported = false)
    void delete(Integer id);

    @Override
    @RestResource(exported = false)
    void delete(OrderItem entity);
}
