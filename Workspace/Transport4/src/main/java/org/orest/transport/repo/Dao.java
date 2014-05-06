package org.orest.transport.repo;

import java.util.List;

import org.orest.transport.domain.Vehicle;
import org.orest.transport.domain.Stop;

public interface Dao {

    List<Stop> findAllStops();

    List<? extends Vehicle> findAllVehicles(Class<? extends Vehicle> vehicleType);

}
