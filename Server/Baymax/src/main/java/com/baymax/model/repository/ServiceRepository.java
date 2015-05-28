package com.baymax.model.repository;

import com.baymax.model.entity.Service;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by Killua on 5/23/15.
 */
public interface ServiceRepository extends CrudRepository<Service, Short> {

    @Query("select s from Service s where s.obsolete = false")
    Iterable<Service> findAll();
}
