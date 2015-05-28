package com.baymax.model.projection;

import com.baymax.model.entity.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.rest.core.config.Projection;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by Killua on 5/24/15.
 */

@Projection(name = "orderHeader", types = { Order.class })
public interface OrderHeaderProjection {

    @Value("#{target.automobile.getLogoFilename()}")
    String getLogoFilename();

    String getDescription();

    Timestamp getCreateTime();

    Timestamp getServiceTime();

    double getAmount();

    String getStatusName();
}
