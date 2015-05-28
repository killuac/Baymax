package com.baymax.model.projection;

import com.baymax.model.entity.OrderItem;
import org.springframework.data.rest.core.config.Projection;

/**
 * Created by Killua on 5/23/15.
 */

@Projection(types = { OrderItem.class })
public interface OrderDetailProjection {

    String getItemName();

    double getPrice();

    byte getQuantity();

    String getDescription();
}
