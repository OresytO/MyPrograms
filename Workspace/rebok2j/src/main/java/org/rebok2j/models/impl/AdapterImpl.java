package org.rebok2j.models.impl;

import org.rebok2j.dao.Dao;
import org.rebok2j.domain.*;
import org.rebok2j.models.Adapter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

@Component
public class AdapterImpl implements Adapter {
    @Autowired
    Dao<Authorization> authorizationDao;

    @Autowired
    Dao<CourierCompany> courierCompanyDao;

    @Autowired
    Dao<Delivery> deliveryDao;

    @Autowired
    Dao<DeliveryType> deliveryTypeDao;

    @Autowired
    Dao<IdType> idTypeDao;

    @Autowired
    Dao<Location> locationDao;

    private Model model;

    @Override
    public Adapter getAuthorizationModel(String attributeName) {
        this.model.addAttribute(attributeName, authorizationDao.getResultList());
        return this;
    }

    @Override
    public Adapter getCourierCompanyModel(String attributeName) {
        this.model.addAttribute(attributeName, courierCompanyDao.getResultList());
        return this;
    }

    @Override
    public Adapter getDeliveryModel(String attributeName) {
        this.model.addAttribute(attributeName, deliveryDao.getResultList());
        return this;
    }

    @Override
    public Adapter getDeliveryTypeModel(String attributeName) {
        this.model.addAttribute(attributeName, deliveryTypeDao.getResultList());
        return this;
    }

    @Override
    public Adapter getIdTypeModel(String attributeName) {
        this.model.addAttribute(attributeName, idTypeDao.getResultList());
        return this;
    }

    @Override
    public Adapter getLocationModel(String attributeName) {
        this.model.addAttribute(attributeName, locationDao.getResultList());
        return this;
    }

    @Override
    public Model getModel() {
        return this.model;
    }

    @Override
    public void setModel(Model model) {
        this.model = model;
    }

}
