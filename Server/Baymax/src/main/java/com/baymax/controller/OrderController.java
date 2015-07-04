package com.baymax.controller;

import com.baymax.model.entity.Order;
import com.baymax.model.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.hateoas.EntityLinks;
import org.springframework.hateoas.Resource;
import org.springframework.hateoas.ResourceProcessor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by Killua on 5/8/15.
 */

@RestController
@RequestMapping("/api/orders")
public class OrderController implements ResourceProcessor<Resource<Order>> {

    private final OrderService orderService;
    private final EntityLinks entityLinks;

    @Autowired
    public OrderController(OrderService orderService, EntityLinks entityLinks) {
        this.orderService = orderService;
        this.entityLinks = entityLinks;
    }

    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(method = RequestMethod.POST)
    public Order create(@RequestBody Order anOrder) {
        return orderService.save(anOrder);
    }

    @ResponseStatus(HttpStatus.OK)
    @RequestMapping(value = "/{orderId}", method = RequestMethod.PATCH)
    public void update(@RequestBody Order anOrder) {
        orderService.save(anOrder);
    }

    @RequestMapping(method = RequestMethod.GET)
    public List<Order> findAll() {
        return orderService.findAll();
    }

    @RequestMapping(value = "/{orderId}", method = RequestMethod.GET)
    public Order findOne(@PathVariable int orderId) {
        return orderService.findOne(orderId);
    }

    @Override
    public Resource<Order> process(Resource<Order> resource) {
        return resource;
    }
}
