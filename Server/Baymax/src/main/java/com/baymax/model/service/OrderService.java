package com.baymax.model.service;

import com.baymax.model.entity.Order;
import com.baymax.model.entity.OrderItem;
import com.baymax.model.repository.AutomobileRepository;
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
    private final AutomobileRepository automobileRepository;

    @Autowired
    public OrderService(OrderRepository orderRepository, OrderItemRepository orderItemRepository, AutomobileRepository automobileRepository) {
        this.orderRepository = orderRepository;
        this.orderItemRepository = orderItemRepository;
        this.automobileRepository = automobileRepository;
    }

    @Transactional
    public Order save(Order anOrder) {
        anOrder.setAutomobile(automobileRepository.findOne(anOrder.getAutomobileId()));
        Iterable<OrderItem> orderItems = anOrder.getOrderItems();
        for (OrderItem orderItem : orderItems) {
            orderItem.setOrder(anOrder);
            orderItem.setPrice(orderItem.getPrice());
        }

        anOrder.setAmount(anOrder.getAmount());
        Order order = orderRepository.save(anOrder);

        for (OrderItem orderItem : orderItems) {
            orderItem.setOrderId(order.getOrderId());
        }
        orderItemRepository.save(orderItems);

        return order;
    }

    public List<Order> findAll() {
        return orderRepository.findAll();
    }

    public Order findOne(int orderId) {
        return orderRepository.findOne(orderId);
    }
}
