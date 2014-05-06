package org.orest.transport.repo;

import java.util.List;

import org.orest.transport.domain.AbstractVehicle;
import org.orest.transport.domain.Stop;

public interface Dao {

    List<Stop> findAllStops();

    List<? extends AbstractVehicle> findAllVehicles(Class<? extends AbstractVehicle> vehicleType);

}
