package org.orest.transport.repo;

import java.util.List;

import org.orest.transport.domain.Route;
import org.orest.transport.domain.Stop;

public interface Dao {

    List<Stop> findAllStops();

    List<? extends Route> findAllRoutes(Class<? extends Route> vehicleType);

    Route findRouteByID(Integer id, Class<? extends Route> vehicleType);

    Stop findStopByName(String name);

    void addStop(Integer id, Class<? extends Route> vehicleType, String stopName);

    void removeStopFromRoute(Integer id, Class<? extends Route> vehicleType, String stopName);

    void addRoute(Class<? extends Route> routeType, String numOfRoute);

    void removeRoute(Class<? extends Route> routeType, String routeName);

}
