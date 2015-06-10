package com.baymax.controller;

import com.baymax.model.entity.User;
import com.baymax.model.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.hateoas.EntityLinks;
import org.springframework.hateoas.Resource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * Created by Killua on 4/29/15.
 */

@RestController
@RequestMapping("/api/users")
public class UserController {

    private final String REL_AUTOMOBILES = "automobiles";
    private final String REL_ADDRESSES   = "addresses";
    private final static Logger logger = LoggerFactory.getLogger(UserController.class);
    private final UserService userService;
    private final EntityLinks entityLinks;

    @Autowired
    public UserController(UserService userService, EntityLinks entityLinks) {
        this.userService = userService;
        this.entityLinks = entityLinks;
    }

    @RequestMapping(value = "/signIn", method = RequestMethod.POST)
    public HttpEntity signIn(@RequestBody User anUser) {
        User user = userService.signIn(anUser);
        if (null != user) {
            HttpStatus status = anUser.isWrongPassword() ? HttpStatus.UNAUTHORIZED : HttpStatus.OK;
            Resource<User> resource = new Resource<User>(user);
            if (HttpStatus.OK == status) {
                resource.add(entityLinks.linkToSingleResource(user));
                resource.add(entityLinks.linkForSingleResource(user).slash(REL_AUTOMOBILES).withRel(REL_AUTOMOBILES));
                resource.add(entityLinks.linkForSingleResource(user).slash(REL_ADDRESSES).withRel(REL_ADDRESSES));
            }
            return new ResponseEntity(resource, status);
        } else {
            return new ResponseEntity(null, HttpStatus.NOT_FOUND);
        }
    }

    @ResponseStatus(HttpStatus.OK)
    @RequestMapping(value = "/signOut/{userId}", method = RequestMethod.GET)
    public void signOut(@PathVariable int userId) {
        userService.signOut(userId);
    }
}
