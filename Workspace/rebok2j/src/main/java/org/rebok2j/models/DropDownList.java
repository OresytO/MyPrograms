package org.rebok2j.models;

import java.util.Map;

public interface DropDownList {

    public abstract Map<Object, Object> getMap();

    public abstract void setMap(Map<Object, Object> map);

    public abstract boolean put(Object key, Object isSelected);

}