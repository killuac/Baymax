package com.baymax.model.repository;

import com.baymax.model.entity.Automobile;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RestResource;

import java.util.List;

/**
 * Created by Killua on 5/8/15.
 */
public interface AutomobileRepository extends JpaRepository<Automobile, Integer> {

    @Query("select a from Automobile a inner join a.autoModel m inner join m.autoSeries s inner join s.autoBrand b where b.brandName like %:brandName%")
    List<Automobile> findByBrandName(@Param("brandName") String brandName);

    @Override
    @RestResource(exported = false)
    void delete(Integer id);

    @Override
    @RestResource(exported = false)
    void delete(Automobile entity);
}
