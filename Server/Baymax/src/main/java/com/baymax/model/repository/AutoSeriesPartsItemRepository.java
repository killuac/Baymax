package com.baymax.model.repository;

import com.baymax.model.entity.AutoSeriesPartsItem;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by Killua on 5/30/15.
 */
public interface AutoSeriesPartsItemRepository extends CrudRepository<AutoSeriesPartsItem, AutoSeriesPartsItem.CompositeId> {
}
