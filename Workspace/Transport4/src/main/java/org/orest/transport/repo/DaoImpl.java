package org.orest.transport.repo;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.orest.transport.domain.Stop;
import org.orest.transport.domain.Vehicle;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class DaoImpl implements Dao {

    @PersistenceContext(name = "primary")
    private EntityManager entityManager;

    @Transactional
    @Override
    public List<Stop> findAllStops() {
        List<Stop> stops = entityManager.createQuery("from Stop", Stop.class).getResultList();
        return stops;
    }

    @Transactional
    @Override
    public List<? extends Vehicle> findAllVehicles(Class<? extends Vehicle> vehicleType) {
        List<? extends Vehicle> stops = entityManager.createQuery("from " + vehicleType.getSimpleName(), vehicleType).getResultList();
        return stops;
    }
}
