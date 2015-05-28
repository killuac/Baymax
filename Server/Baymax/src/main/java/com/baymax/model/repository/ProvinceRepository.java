package com.baymax.model.repository;

import com.baymax.model.entity.Province;
import org.springframework.context.annotation.Profile;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by Killua on 5/23/15.
 */
public interface ProvinceRepository extends CrudRepository<Province, Short> {

    Iterable<Profile> findByOpenedTrue();
}
