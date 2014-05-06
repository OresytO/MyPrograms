package org.orest.transport.domain;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

@Entity
@Inheritance
@Table(name = "vehicles")
public class AbstractVehicle {

    @Id
    @GeneratedValue
    @Column(name = "id", unique = true)
    protected Integer id;

    @Column(name = "route_number")
    private String routeNumber;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "vehicles_to_stops", joinColumns = { @JoinColumn(name = "vechicle_id", updatable = true, nullable = true) }, inverseJoinColumns = { @JoinColumn(name = "stop_id", updatable = true, nullable = true) })
    protected Set<Stop> stops;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNumberOfRout() {
        return routeNumber;
    }

    public void setNumberOfRout(String numberOfRout) {
        this.routeNumber = numberOfRout;
    }

    public Set<Stop> getStops() {
        return stops;
    }

    public void setStops(Set<Stop> stops) {
        this.stops = stops;
    }

    public boolean addStop(Stop stop) {
        return stops.add(stop);
    }

    public boolean removeStop(Stop stop) {
        return stops.remove(stop);
    }

}
