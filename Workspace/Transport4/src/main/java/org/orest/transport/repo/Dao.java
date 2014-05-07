package org.orest.transport.repo;

import java.util.List;

import org.orest.transport.domain.Stop;
import org.orest.transport.domain.Vehicle;

public interface Dao {

    List<Stop> findAllStops();

    List<? extends Vehicle> findAllVehicles(Class<? extends Vehicle> vehicleType);

    Vehicle findVehicleByID(Integer id, Class<? extends Vehicle> vehicleType);

    Stop findStopByName(String name);

    String addStop(Integer id, Class<? extends Vehicle> vehicleType, String stopName);

}
