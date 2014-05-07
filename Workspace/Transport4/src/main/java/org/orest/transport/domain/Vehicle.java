package org.orest.transport.domain;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@Table(name = "vehicles")
public class Vehicle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", unique = true)
    protected Integer id;

    @Column(name = "route_number")
    private String routeNumber;

    @ManyToMany(cascade = { CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH }, fetch = FetchType.EAGER)
    @JoinTable(name = "vehicles_to_stops", joinColumns = { @JoinColumn(name = "vechicle_id", updatable = true, nullable = true) }, inverseJoinColumns = { @JoinColumn(name = "stop_id", updatable = true, nullable = true) })
    protected Set<Stop> stops;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getRouteNumber() {
        return routeNumber;
    }

    public void setRouteNumber(String routeNumber) {
        this.routeNumber = routeNumber;
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

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((routeNumber == null) ? 0 : routeNumber.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Vehicle other = (Vehicle) obj;
        if (routeNumber == null) {
            if (other.routeNumber != null)
                return false;
        } else if (!routeNumber.equals(other.routeNumber))
            return false;
        return true;
    }

}
