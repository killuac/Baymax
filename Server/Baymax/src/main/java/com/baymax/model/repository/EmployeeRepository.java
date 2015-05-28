package com.baymax.model.repository;

import com.baymax.model.entity.Employee;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.rest.core.annotation.RestResource;

/**
 * Created by Killua on 5/23/15.
 */
public interface EmployeeRepository extends CrudRepository<Employee, String> {

    @Override
    @RestResource(exported = false)
    void delete(String id);

    @Override
    @RestResource(exported = false)
    void delete(Employee entity);
}
