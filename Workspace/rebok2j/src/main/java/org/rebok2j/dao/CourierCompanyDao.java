package org.rebok2j.dao;

import org.rebok2j.domain.CourierCompany;

public interface CourierCompanyDao {

    void persist(CourierCompany courierCompany);

    CourierCompany merge(CourierCompany courierCompany);

    void remove(CourierCompany courierCompany);

    CourierCompany findById(Long id);

}
