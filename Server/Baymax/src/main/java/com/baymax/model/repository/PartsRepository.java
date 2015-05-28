package com.baymax.model.repository;

import com.baymax.model.entity.Parts;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by Killua on 5/23/15.
 */
public interface PartsRepository extends CrudRepository<Parts, Short> {

    Iterable<Parts> findByObsoleteFalse();
}
