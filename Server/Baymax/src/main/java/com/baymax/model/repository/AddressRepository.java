package com.baymax.model.repository;

import com.baymax.model.entity.Address;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.rest.core.annotation.RestResource;

/**
 * Created by Killua on 5/23/15.
 */
public interface AddressRepository extends CrudRepository<Address, Integer> {

    @Override
    @RestResource(exported = false)
    void delete(Integer id);

    @Override
    @RestResource(exported = false)
    void delete(Address entity);
}
