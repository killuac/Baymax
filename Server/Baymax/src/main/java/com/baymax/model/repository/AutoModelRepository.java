package com.baymax.model.repository;

import com.baymax.model.entity.AutoModel;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by Killua on 5/23/15.
 */
public interface AutoModelRepository extends CrudRepository<AutoModel, Short> {

    Iterable<AutoModel> findByObsoleteFalse();
}
