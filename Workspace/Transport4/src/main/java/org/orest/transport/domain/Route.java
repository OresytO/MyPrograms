package org.orest.transport.domain;

import java.util.HashSet;
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
@Table(name = "routes")
public class Route {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", unique = true)
    protected Integer id;

    @Column(name = "number_of_route")
    private String numOfRoute;

    @ManyToMany(cascade = { CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH }, fetch = FetchType.EAGER)
    @JoinTable(name = "routes_to_stops", joinColumns = { @JoinColumn(name = "route_id", updatable = true, nullable = true) }, inverseJoinColumns = { @JoinColumn(name = "stop_id", updatable = true, nullable = true) })
    protected Set<Stop> stops = new HashSet<Stop>();

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNumOfRoute() {
        return numOfRoute;
    }

    public void setNumOfRoute(String numOfRoute) {
        this.numOfRoute = numOfRoute;
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
        result = prime * result + ((numOfRoute == null) ? 0 : numOfRoute.hashCode());
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
        Route other = (Route) obj;
        if (numOfRoute == null) {
            if (other.numOfRoute != null)
                return false;
        } else if (!numOfRoute.equals(other.numOfRoute))
            return false;
        return true;
    }

    @Override
    public String toString() {
        return this.getClass().getSimpleName() + " [id=" + id + ", numOfRoute=" + numOfRoute + ", stops=" + stops + "]";
    }

}
