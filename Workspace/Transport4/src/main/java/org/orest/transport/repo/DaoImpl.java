package org.orest.transport.repo;

import java.util.List;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.orest.transport.domain.Route;
import org.orest.transport.domain.Stop;
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
    public List<? extends Route> findAllRoutes(Class<? extends Route> routeType) {
        List<? extends Route> stops = entityManager.createQuery("from " + routeType.getSimpleName(), routeType).getResultList();
        return stops;
    }

    @Transactional
    @Override
    public void addStop(Integer id, Class<? extends Route> routeType, String stopName) {
        Route route = findRouteByID(id, routeType);
        Stop stop = findStopByName(stopName);
        if (stop == null) {
            stop = new Stop();
            stop.setName(stopName);
            entityManager.persist(stop);
        }
        route.addStop(stop);
        entityManager.merge(route);
    }

    @Transactional
    @Override
    public void addRoute(Class<? extends Route> routeType, String numOfRoute) {
        Route route = findRouteByName(numOfRoute, routeType);
        if (route == null) {
            route = createRoute(routeType);
            route.setNumOfRoute(numOfRoute);
            entityManager.persist(route);
        }
        entityManager.merge(route);
    }

    private Route findRouteByName(String routeName, Class<? extends Route> routeType) {
        Route route;
        try {
            route = entityManager.createNamedQuery(routeType.getSimpleName() + ".findByName", routeType).setParameter(1, routeName).getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
        return route;
    }

    @Transactional
    @Override
    public void removeStopFromRoute(Integer id, Class<? extends Route> routeType, String stopName) {
        Stop stop = findStopByName(stopName);
        Route route = findRouteByID(id, routeType);

        removeStopFromRoute(stop, route);
    }

    @Override
    public Route findRouteByID(Integer id, Class<? extends Route> routeType) {
        return entityManager.find(routeType, id);
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

    private void removeStopFromRoute(Stop stop, Route route) {
        if (stop == null)
            return;
        if (route == null)
            throw new IllegalArgumentException("vehicle can't be null!!");
        if (isEmptySet(route.getStops()))
            throw new IllegalArgumentException("vehicle can't be null or empty!!");
        if (isEmptySet(stop.getRoutes()))
            return;

        stop.removeRoute(route);
        route.removeStop(stop);
        if (stop.getRoutes().size() > 0)
            entityManager.merge(stop);
        else
            entityManager.remove(stop);
    }

    private boolean isEmptySet(Set<?> set) {
        if (set == null || set.size() <= 0)
            return true;
        return false;
    }

    @SuppressWarnings("unchecked")
    private <T extends Route> T createRoute(Class<? extends Route> routeType) {
        try {
            return (T) routeType.newInstance();
        } catch (InstantiationException | IllegalAccessException e) {
            throw new IllegalArgumentException("New Instantiation Exception", e);
        }
    }
}
