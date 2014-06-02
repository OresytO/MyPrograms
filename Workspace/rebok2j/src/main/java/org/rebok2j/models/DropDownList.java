package org.rebok2j.models;

import java.util.Map;

public interface DropDownList {

    public abstract Map<String, Boolean> getMap();

    public abstract void setMap(Map<String, Boolean> map);

    public abstract boolean put(String key, Boolean isSelected);

}