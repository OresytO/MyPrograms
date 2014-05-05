package domain.impl;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import domain.Stop;
import domain.Vehicle;

@Entity
@Table(name = "stops")
public class StopImpl implements Stop {

    @Id
    private Integer id;

    @Column(name = "name")
    private String name;

    @ManyToMany
    private Set<Vehicle> vehicles;

    @Override
    public Integer getId() {
        return id;
    }

    @Override
    public void setId(Integer id) {
        this.id = id;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public void setName(String name) {
        this.name = name;
    }

    @Override
    public Set<Vehicle> getVehicles() {
        return vehicles;
    }

    @Override
    public void setVehicles(Set<Vehicle> vehicles) {
        this.vehicles = vehicles;
    }

}
