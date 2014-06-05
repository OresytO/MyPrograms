package org.rebok2j.service.impl;

import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.rebok2j.dao.Dao;
import org.rebok2j.models.DropDownList;
import org.rebok2j.models.DropDownListWrapper;
import org.rebok2j.service.RebokService;
import org.springframework.beans.factory.annotation.Autowired;

public abstract class AbstractService<T> implements RebokService {

    @Autowired
    Dao<T> dao;

    @SuppressWarnings("unchecked")
    public Map<Object, Object> getMapFromDB(Dao<?> dao, String namedQuery) throws InstantiationException, IllegalAccessException {

        List<Object> resultList = (List<Object>) dao.getResultListFromNamedQuery(namedQuery, null);
        Map<Object, Object> resultMap = new TreeMap<>();
        for (Object key : resultList) {
            resultMap.put(key, false);
        }
        return resultMap;
    }

    @Override
    public DropDownList fillDropDownList(String queryName) throws InstantiationException, IllegalAccessException {
        DropDownList deliveryType = new DropDownListWrapper();
        deliveryType.setMap(getMapFromDB(dao, queryName));
        System.out.println(deliveryType.getMap());
        return deliveryType;
    }

}