package org.rebok2j.models.impl;

import org.rebok2j.dao.*;
import org.rebok2j.models.Adapter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.LinkedHashMap;
import java.util.Map;

@Component
public class AdapterImpl implements Adapter {
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
        this.model.put(attributeName, deliveryTypeDao.getResultList());
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
