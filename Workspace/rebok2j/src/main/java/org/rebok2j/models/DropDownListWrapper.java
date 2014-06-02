package org.rebok2j.models;

import java.util.Map;

public class DropDownListWrapper implements DropDownList {
    private Map<String, Boolean> map;

    /*------------------------------*/

    @Override
    public Map<String, Boolean> getMap() {
        return map;
    }

    @Override
    public void setMap(Map<String, Boolean> map) {
        this.map = map;
    }

    @Override
    public boolean put(String key, Boolean isSelected) {
        return map.put(key, isSelected);
    }

}
