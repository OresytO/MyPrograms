package org.rebok2j.models.impl;

import org.rebok2j.models.DropDown;

import java.io.Serializable;
import java.util.Map;

public class DropDownListWrapper implements DropDown, Serializable {
    private static final long serialVersionUID = -8519052720321834702L;
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
