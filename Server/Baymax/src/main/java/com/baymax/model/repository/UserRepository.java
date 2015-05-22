package com.baymax.model.repository;

import com.baymax.model.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RestResource;

/**
 * Created by Killua on 4/29/15.
 */
//@RepositoryRestResource(exported = false)
public interface UserRepository extends JpaRepository<User, Integer> {

    @Query("select u from User u where u.mobile = :mobile")
    User findByMobile(@Param("mobile") String mobile);

    @Query("select u from User u where u.userName = :userName")
    User findByUserName(@Param("userName") String userName);

    @Override
    @RestResource(exported = false)
    void delete(Integer id);

    @Override
    @RestResource(exported = false)
    void delete(User user);
}
