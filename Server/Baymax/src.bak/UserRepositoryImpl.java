package com.baymax.model.repository;

import com.baymax.model.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceUnit;
import java.util.List;

/**
 * Created by Killua on 4/29/15.
 */

@Repository
public class UserRepositoryImpl implements UserRepository {

    private EntityManager entityManager;

    @PersistenceContext
    public void setEntityManager(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    @Override
    public List<User> findAll() {
        return entityManager.createQuery("from User")
                .getResultList();
    }

    @Override
    public User save(User user) {
        entityManager.persist(user);
        return user;
    }

    @Override
    public User findOne(Integer userId) {
        return (User) entityManager.createQuery("from User where userId = ?1")
                .setParameter(1, userId)
                .getSingleResult();
    }

    @Override
    public long count() {
        return (long) entityManager.createQuery("count(*) from User")
                .getSingleResult();
    }

    @Override
    public void delete(Integer userId) {
        entityManager.createQuery("delete from User where userId = ?1")
                .setParameter(1, userId)
                .executeUpdate();
    }
}
