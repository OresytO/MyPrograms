package org.rebok2j.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.rebok2j.dao.Dao;
import org.rebok2j.dao.impl.DaoImpl;
import org.rebok2j.domain.DeliveryType;
import org.rebok2j.models.DropDownList;
import org.rebok2j.models.DropDownListWrapper;
import org.rebok2j.service.DeliveryTypeService;
import org.springframework.stereotype.Service;

@Service
public class DeliveryTypeServiceImpl implements DeliveryTypeService {

    @Override
    public DropDownList fillDropDownList() throws InstantiationException, IllegalAccessException {
        DropDownList deliveryType = new DropDownListWrapper();
        deliveryType.setMap(getMapFromDB(new DaoImpl<DeliveryType>(), "DeliveryType.findAll"));
        return deliveryType;
    }

    @SuppressWarnings("unchecked")
    public Map<Object, Object> getMapFromDB(Dao<?> dao, String namedQuery) throws InstantiationException, IllegalAccessException {

        List<Object> resultList = (List<Object>) dao.getResultListFromNamedQuery(namedQuery, null);
        Map<Object, Object> resultMap = new HashMap<>();
        for (Object key : resultList) {
            resultMap.put(key, false);
        }
        return resultMap;
    }
}
