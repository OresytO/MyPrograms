package org.rebok2j.dao;

import org.rebok2j.domain.CourierCompany;

public interface DeliveryDao {

    void persist(CourierCompany courierCompany);

    CourierCompany merge(CourierCompany courierCompany);

    void remove(CourierCompany courierCompany);

    CourierCompany findById(Integer id);

}
