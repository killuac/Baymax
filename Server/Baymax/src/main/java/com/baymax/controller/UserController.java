package com.baymax.controller;

import com.baymax.model.entity.User;
import com.baymax.model.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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

    private final static Logger logger = LoggerFactory.getLogger(UserController.class);
    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping(value = "/signIn", method = RequestMethod.GET)
    public HttpEntity<User> signIn(@RequestBody User anUser) {
        User user = userService.signIn(anUser);
        HttpStatus status;
        if (null != anUser) {
            status = anUser.isWrongPassword() ? HttpStatus.UNAUTHORIZED : HttpStatus.OK;
        } else {
            status = HttpStatus.NOT_FOUND;
        }
        return new ResponseEntity<User>(user, status);
    }

    @RequestMapping(value = "/singOut", method = RequestMethod.PATCH)
    public void signOut(@PathVariable String mobile) {
        userService.signOut();
    }
}
