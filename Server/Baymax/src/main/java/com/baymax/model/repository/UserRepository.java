package com.baymax.model.repository;

import com.baymax.model.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RestResource;

/**
 * Created by Killua on 4/29/15.
 */
public interface UserRepository extends JpaRepository<User, Integer> {

    User findByMobile(String mobile);

    User findByUserName(String userName);

    @Query("select new User(u.mobile, u.password) from User u where u.mobile = :mobile")
    @RestResource(exported = false)
    User getPasswordByMobile(@Param("mobile") String mobile);

    @Override
    @RestResource(exported = false)
    void delete(Integer id);

    @Override
    @RestResource(exported = false)
    void delete(User entity);
}
