package com.baymax.model.repository;

import com.baymax.model.entity.Payment;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by Killua on 5/24/15.
 */
public interface PaymentRepository extends CrudRepository<Payment, Short> {

    Iterable<Payment> findByObsoleteFalse();
}
