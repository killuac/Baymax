package com.baymax.controller;

import com.baymax.model.entity.Order;
import com.baymax.model.service.OrderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.hateoas.EntityLinks;
import org.springframework.hateoas.Resource;
import org.springframework.hateoas.ResourceProcessor;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;

/**
 * Created by Killua on 5/8/15.
 */

@RestController
@RequestMapping("/api/orders")
public class OrderController implements ResourceProcessor<Resource<Order>> {

    private final static Logger logger = LoggerFactory.getLogger(UserController.class);

    private final OrderService orderService;
    private final EntityLinks entityLinks;

    @Autowired
    public OrderController(OrderService orderService, EntityLinks entityLinks) {
        this.orderService = orderService;
        this.entityLinks = entityLinks;
    }

    @RequestMapping(method = RequestMethod.POST)
    public HttpEntity create(@RequestBody Order anOrder) {
        Order order = orderService.save(anOrder);

        HttpHeaders headers = new HttpHeaders();
        try {
            headers.setLocation(new URI(entityLinks.linkToSingleResource(order).getHref()));
        } catch (URISyntaxException e) {
            logger.error(e.getMessage());
        }

        return new ResponseEntity(headers, HttpStatus.CREATED);
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
