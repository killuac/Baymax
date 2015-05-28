package com.baymax.model.service;

import com.baymax.model.entity.Order;
import com.baymax.model.entity.OrderItem;
import com.baymax.model.repository.OrderItemRepository;
import com.baymax.model.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Killua on 5/8/15.
 */

@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final OrderItemRepository orderItemRepository;

    @Autowired
    public OrderService(OrderRepository orderRepository, OrderItemRepository orderItemRepository) {
        this.orderRepository = orderRepository;
        this.orderItemRepository = orderItemRepository;
    }

    @Transactional
    public Order save(Order anOrder) {
        Order order = orderRepository.save(anOrder);
        Iterable<OrderItem> orderItems = anOrder.getOrderItems();
        for (OrderItem orderItem : orderItems) {
            orderItem.setOrder(order);
        }
        orderItems = orderItemRepository.save(orderItems);
        order.setOrderItems((List)orderItems);
        return order;
    }
}
