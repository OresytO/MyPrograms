package domain;

import java.util.Set;

public interface Stop {
    public Integer getId();

    public void setId(Integer id);

    public String getName();

    public void setName(String name);

    public Set<Vehicle> getVehicles();

    public void setVehicles(Set<Vehicle> vehicles);
}
