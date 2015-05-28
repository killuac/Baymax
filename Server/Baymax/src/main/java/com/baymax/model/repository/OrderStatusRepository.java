package com.baymax.model.repository;

import com.baymax.model.entity.OrderStatus;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by Killua on 5/23/15.
 */
public interface OrderStatusRepository extends CrudRepository<OrderStatus, Short> {
}
