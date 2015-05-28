package com.baymax.model.repository;

import com.baymax.model.entity.AutoBrand;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by Killua on 5/12/15.
 */
public interface AutoBrandRepository extends CrudRepository<AutoBrand, Short> {

    Iterable<AutoBrand> findByObsoleteFalse();
}
