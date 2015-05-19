package com.baymax.model.repository;

import com.baymax.model.entity.Automobile;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by Killua on 5/8/15.
 */
public interface AutomobileRepository extends JpaRepository<Automobile, Integer> {
}
