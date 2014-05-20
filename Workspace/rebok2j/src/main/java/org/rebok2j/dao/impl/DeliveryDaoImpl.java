package org.rebok2j.dao.impl;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.rebok2j.dao.DeliveryDao;
import org.rebok2j.domain.CourierCompany;
import org.springframework.stereotype.Repository;

@Repository
public class DeliveryDaoImpl implements DeliveryDao {

    @PersistenceContext
    // (name = "primary")
    private EntityManager entityManager;

    @Override
    public void persist(CourierCompany courierCompany) {
        entityManager.persist(courierCompany);
    }

    @Override
    public CourierCompany merge(CourierCompany courierCompany) {
        return entityManager.merge(courierCompany);
    }

    @Override
    public void remove(CourierCompany courierCompany) {
        entityManager.remove(courierCompany);
    }

    @Override
    public CourierCompany findById(Long id) {
        return entityManager.find(CourierCompany.class, id);
    }
}
