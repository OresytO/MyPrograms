package org.orest.transport.repo;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.orest.transport.domain.Stop;
import org.orest.transport.domain.Vehicle;
import org.springframework.stereotype.Repository;

@Repository
public class DaoImpl implements Dao {

    @PersistenceContext(name = "primary")
    private EntityManager entityManager;

    @Override
    public List<Stop> findAllStops() {
        List<Stop> stops = entityManager.createQuery("from Stop s", Stop.class).getResultList();
        return stops;
    }

    @Override
    public List<? extends Vehicle> findAllVehicles(Class<? extends Vehicle> vehicleType) {
        List<? extends Vehicle> stops = entityManager.createQuery("from " + vehicleType.getSimpleName(), vehicleType).getResultList();
        return stops;
    }

    @Transactional
    @Override
    public String addStop(Integer id, Class<? extends Vehicle> vehicleType, String stopName) {
        String res = "";
        Vehicle vehicle = findVehicleByID(id, vehicleType);
        Stop stop = findStopByName(stopName);
        if (stop == null) {
            stop = new Stop();
            stop.setName(stopName);
            // stop.addVehicle(vehicle);
            entityManager.persist(stop);
            res = stop.getName();
        }
        // else {
        // stop.addVehicle(vehicle);
        // stop = entityManager.merge(stop);
        // }
        res.concat(vehicle.getStops().toString());
        vehicle.addStop(stop);
        res.concat(vehicle.getStops().toString());
        entityManager.merge(vehicle);
        return res;
    }

    @Override
    public Vehicle findVehicleByID(Integer id, Class<? extends Vehicle> vehicleType) {
        return entityManager.find(vehicleType, id);
    }

    @Override
    public Stop findStopByName(String name) {
        Stop stop;
        try {
            stop = entityManager.createNamedQuery("findByName", Stop.class).setParameter(1, name).getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
        return stop;
    }
}
