package com.baymax.model.service;

import com.baymax.model.repository.UserRepository;
import com.baymax.model.entity.User;
import com.baymax.common.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

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

    public User signIn(User oneUser) {
        User user = userRepository.findByMobile(oneUser.getMobile());
        if (null != user) {
            if (!user.getPassword().equals(Util.generateHashedPassword(oneUser.getPassword()))) {
                oneUser.setIsWrongPassword(true);
                user = oneUser;
            }
        }
        return user;
    }

    public void signOut() {

    }
}
