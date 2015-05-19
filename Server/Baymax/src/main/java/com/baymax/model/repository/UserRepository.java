package com.baymax.model.repository;

import com.baymax.model.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by Killua on 4/29/15.
 */
public interface UserRepository extends JpaRepository<User, Integer> {

    public User findByUserName(String userName);
    public User findByMobile(String mobile);
}
