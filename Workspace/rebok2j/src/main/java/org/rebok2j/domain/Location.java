package org.rebok2j.domain;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

import static org.rebok2j.utils.DomainConstants.LOCATION;

@Entity
@Table(name = "Locations")
@NamedQueries({@NamedQuery(name = LOCATION.FIND_ALL, query = LOCATION.FIND_ALL_Q)})
public class Location implements Serializable, Comparable<Location> {

    private static final long serialVersionUID = 5683268872194039757L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long Id;

    @Column(name = "locationName")
    private String locationName;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "location")
    private Set<CourierCompany> courierCompanies;

    /*-----------------------------------------------------------*/

    public Location() {
    }

    public long getId() {
        return Id;
    }

    public void setId(long id) {
        Id = id;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }

    public Set<CourierCompany> getCourierCompanies() {
        return courierCompanies;
    }

    public void setCourierCompanies(Set<CourierCompany> courierCompanies) {
        this.courierCompanies = courierCompanies;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + (int) (Id ^ (Id >>> 32));
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
        Location other = (Location) obj;
        if (Id != other.Id)
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "Location [Id=" + Id + ", locationName=" + locationName + "]";
    }

    @Override
    public int compareTo(Location o) {
        return this.getLocationName().compareTo(o.getLocationName());
    }

}
