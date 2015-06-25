package com.baymax.model.service;

import com.baymax.model.repository.UserRepository;
import com.baymax.model.entity.User;
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
            if (!user.getPassword().equals(anUser.getPassword())) {
                anUser.setWrongPassword(true);
                user = anUser;
            }
        } else {
            anUser.setNotFound(true);
            user = anUser;
        }
        return user;
    }

    public void signOut(int userId) {

    }
}
