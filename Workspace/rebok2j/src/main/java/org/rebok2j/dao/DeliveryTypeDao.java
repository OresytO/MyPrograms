package org.rebok2j.dao;

import org.rebok2j.domain.DeliveryType;

public interface DeliveryTypeDao {

    void persist(DeliveryType deliveryType);

    DeliveryType merge(DeliveryType deliveryType);

    void remove(DeliveryType deliveryType);

    DeliveryType findById(Long id);

}
