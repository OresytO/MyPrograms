package domain.impl;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;

import domain.Stop;
import domain.Vehicle;

@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
public class AbstractVehicle implements Vehicle {

    @Id
    private Integer id;

    @Column(name = "route_number")
    private String routeNumber;

    private Set<Stop> stops;

    @Override
    public Integer getId() {
        return id;
    }

    @Override
    public void setId(Integer id) {
        this.id = id;
    }

    @Override
    public String getNumberOfRout() {
        return routeNumber;
    }

    @Override
    public void setNumberOfRout(String numberOfRout) {
        this.routeNumber = numberOfRout;
    }

    @Override
    public Set<Stop> getStops() {
        return stops;
    }

    @Override
    public void setStops(Set<Stop> stops) {
        this.stops = stops;
    }

    @Override
    public boolean addStop(Stop stop) {
        return stops.add(stop);
    }

    @Override
    public boolean removeStop(Stop stop) {
        return stops.remove(stop);
    }

}
