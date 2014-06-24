package org.rebok2j.models;

import java.util.Map;

/**
 * Created by OrestO on 6/23/2014.
 */
public interface DropDown {
    public abstract Map<Object, Object> getMap();

    public abstract void setMap(Map<Object, Object> map);

    public abstract boolean put(Object key, Object isSelected);
}
