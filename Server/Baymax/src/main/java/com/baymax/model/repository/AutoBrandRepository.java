package com.baymax.model.repository;

import com.baymax.model.entity.AutoBrand;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by Killua on 5/12/15.
 */
public interface AutoBrandRepository extends JpaRepository<AutoBrand, Short> {
}
