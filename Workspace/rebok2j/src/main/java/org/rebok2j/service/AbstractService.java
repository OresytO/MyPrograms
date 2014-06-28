package org.rebok2j.service;

import org.rebok2j.dao.GenericDao;
import org.rebok2j.models.DropDown;
import org.rebok2j.models.impl.DropDownListWrapper;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Map;
import java.util.TreeMap;

public abstract class AbstractService<T> implements RebokService {

    @Autowired
    GenericDao<T> dao;

    @SuppressWarnings("unchecked")
    private Map<Object, Object> getMapFromDB(String namedQuery) throws InstantiationException, IllegalAccessException {

        List<Object> resultList = (List<Object>) dao.getResultList();
        Map<Object, Object> resultMap = new TreeMap<>();
        for (Object key : resultList) {
            resultMap.put(key, false);
        }
        return resultMap;
    }

    @Override
    public DropDown fillElement(String queryName) throws InstantiationException, IllegalAccessException {
        DropDown deliveryType = new DropDownListWrapper();
        deliveryType.setMap(getMapFromDB(queryName));
        System.out.println(deliveryType.getMap());
        return deliveryType;
    }

}
