package com.baymax.controller;

import com.baymax.model.entity.User;
import com.baymax.model.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by Killua on 4/29/15.
 */

@RestController
@RequestMapping("/users")
public class UserController {

    private final static Logger logger = LoggerFactory.getLogger(UserController.class);
    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping(method = RequestMethod.POST)
    public User signUp(@RequestBody User user) {
        userService.signUp(user);
        return user;
    }

    @RequestMapping(method = RequestMethod.GET)
    public List<User> getUserList() {
        return userService.getUserList();
    }

    @RequestMapping(value = "/{userId}", method = RequestMethod.PUT)
    public void updateUser(@RequestBody User user) {
        userService.update(user);
    }

    @RequestMapping(value = "/{userId}", method = RequestMethod.GET)
    public User getUser(@PathVariable int userId) {
        return userService.getUserById(userId);
    }

    @RequestMapping(value = "/{userId}", method = RequestMethod.DELETE)
    public void deleteUser(@PathVariable int userId) {
//        userService.delete(userId);
    }

    @RequestMapping(value = "/{mobile}/session", method = RequestMethod.POST)
    public void signIn(@RequestBody User user) {
        userService.signIn(user);
    }

    @RequestMapping(value = "/{mobile}/session", method = RequestMethod.DELETE)
    public void signOut(@PathVariable String mobile) {
        userService.signOut();
    }
}
