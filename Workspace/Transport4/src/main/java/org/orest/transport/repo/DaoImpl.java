package org.orest.transport.repo;

import java.util.List;
import java.util.Set;

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
            entityManager.persist(stop);
        }
        vehicle.addStop(stop);
        entityManager.merge(vehicle);
        return res;
    }

    @Transactional
    @Override
    public String removeStopFromVehicle(Integer id, Class<? extends Vehicle> vehicleType, String stopName) {
        String res = "";
        Stop stop = findStopByName(stopName);
        Vehicle vehicle = findVehicleByID(id, vehicleType);

        removeStopFromVehicle(stop, vehicle);
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

    private void removeStopFromVehicle(Stop stop, Vehicle vehicle) {
        if (stop == null)
            return;
        if (vehicle == null)
            throw new IllegalArgumentException("vehicle can't be null!!");
        if (isEmptySet(vehicle.getStops()))
            throw new IllegalArgumentException("vehicle can't be null or empty!!");
        if (isEmptySet(stop.getVehicles()))
            return;

        stop.removeVehicle(vehicle);
        vehicle.removeStop(stop);
        if (stop.getVehicles().size() > 0)
            entityManager.merge(stop);
        else
            entityManager.remove(stop);
    }

    private boolean isEmptySet(Set set) {
        if (set == null || set.size() <= 0)
            return true;
        return false;
    }
}
