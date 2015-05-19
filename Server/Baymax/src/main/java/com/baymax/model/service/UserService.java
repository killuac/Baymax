package com.baymax.model.service;

import com.baymax.model.repository.UserRepository;
import com.baymax.model.entity.User;
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

    @Transactional
    public void signUp(User user) {
        userRepository.save(user);
    }

    public void signIn(User user) {

    }

    public void signOut() {

    }

    public void update(User user) {
        userRepository.save(user);
    }

    public void delete(int userId) {
        userRepository.delete(userId);
    }

    public User getUserById(int userId) {
        return userRepository.findOne(userId);
    }

    public List getUserList() {
        return userRepository.findAll();
    }
}
