package org.rebok2j.dao.impl;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.rebok2j.dao.DeliveryTypeDao;
import org.rebok2j.domain.DeliveryType;
import org.springframework.stereotype.Repository;

@Repository
public class DeliveryTypeDaoImpl implements DeliveryTypeDao {

    @PersistenceContext
    // (name = "primary")
    private EntityManager entityManager;

    @Override
    public void persist(DeliveryType deliveryType) {
        entityManager.persist(deliveryType);
    }

    @Override
    public DeliveryType merge(DeliveryType deliveryType) {
        return entityManager.merge(deliveryType);
    }

    @Override
    public void remove(DeliveryType deliveryType) {
        entityManager.remove(deliveryType);
    }

    @Override
    public DeliveryType findById(Long id) {
        return entityManager.find(DeliveryType.class, id);
    }

}
