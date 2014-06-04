package org.rebok2j.models;

import java.util.Map;

public class DropDownListWrapper implements DropDownList {
    private Map<Object, Object> map;

    /*------------------------------*/

    @Override
    public Map<Object, Object> getMap() {
        return map;
    }

    @Override
    public boolean put(Object key, Object isSelected) {
        return (Boolean) map.put(key, isSelected);
    }

    @Override
    public void setMap(Map<Object, Object> map) {
        this.map = map;
    }

}
