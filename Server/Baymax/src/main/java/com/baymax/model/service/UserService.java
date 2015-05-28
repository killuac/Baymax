package com.baymax.model.service;

import com.baymax.model.repository.UserRepository;
import com.baymax.model.entity.User;
import com.baymax.common.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Killua on 5/4/15.
 */

@Service
public class UserService {

    private final UserRepository userRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User signIn(User anUser) {
        User user = userRepository.findByMobile(anUser.getMobile());
        if (null != user) {
            if (!user.getPassword().equals(Util.generateHashedPassword(anUser.getPassword()))) {
                anUser.setWrongPassword(true);
                user = anUser;
            }
        }
        return user;
    }

    public void signOut() {

    }
}
