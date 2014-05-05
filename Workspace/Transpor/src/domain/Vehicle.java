package domain;

import java.util.Set;

public interface Vehicle {
    public Integer getId();

    public void setId(Integer id);

    public String getNumberOfRout();

    public void setNumberOfRout(String numberOfRout);

    public Set<Stop> getStops();

    public void setStops(Set<Stop> stops);

    public boolean addStop(Stop stop);

    public boolean removeStop(Stop stop);
}
