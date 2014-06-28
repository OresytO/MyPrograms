package org.rebok2j.models.impl;

import org.apache.log4j.Logger;
import org.rebok2j.dao.*;
import org.rebok2j.domain.Authorization;
import org.rebok2j.domain.DeliveryType;
import org.rebok2j.models.Adapter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Component
public class AdapterImpl implements Adapter {
    private static Logger log = Logger.getLogger(AdapterImpl.class);

    @Autowired
    AuthorizationDao authorizationDao;

    @Autowired
    CourierCompanyDao courierCompanyDao;

    @Autowired
    DeliveryDao deliveryDao;

    @Autowired
    DeliveryTypeDao deliveryTypeDao;

    @Autowired
    IdTypeDao idTypeDao;

    @Autowired
    LocationDao locationDao;

    private Map<String, Object> model;

    public AdapterImpl() {
        this.model = new LinkedHashMap<>();
    }

    @Override
    public Adapter getAuthorizationModel(String attributeName) {
        this.model.put(attributeName, authorizationDao.getResultList());
        return this;
    }

    @Override
    public Adapter getCourierCompanyModel(String attributeName) {
        this.model.put(attributeName, courierCompanyDao.getResultList());
        return this;
    }

    @Override
    public Adapter getDeliveryModel(String attributeName) {
        this.model.put(attributeName, deliveryDao.getResultList());
        return this;
    }

    @Override
    public Adapter getDeliveryTypeModel(String attributeName) {
        log.error("------- getDeliveryTypeModel ------ start");
        List<DeliveryType> list = deliveryTypeDao.getResultList();
        log.error(attributeName + " -> " + list.toString());
        this.model.put(attributeName, list);

        log.error("------- getDeliveryTypeModel ------ end");
        return this;
    }

    @Override
    public Adapter getIdTypeModel(String attributeName) {
        this.model.put(attributeName, idTypeDao.getResultList());
        return this;
    }

    @Override
    public Adapter getLocationModel(String attributeName) {
        this.model.put(attributeName, locationDao.getResultList());
        return this;
    }

    @Override
    public Map<String, Object> getModel() {
        return this.model;
    }

    @Override
    public void setModel(Map<String, Object> model) {
        this.model = model;
    }

}
