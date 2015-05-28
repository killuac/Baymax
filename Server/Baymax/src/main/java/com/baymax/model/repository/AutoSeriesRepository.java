package com.baymax.model.repository;

import com.baymax.model.entity.AutoSeries;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.rest.core.annotation.RestResource;

/**
 * Created by Killua on 5/23/15.
 */
public interface AutoSeriesRepository extends CrudRepository<AutoSeries, Short> {

    Iterable<AutoSeries> findByObsoleteFalse();
}
