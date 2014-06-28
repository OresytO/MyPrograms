package org.rebok2j.models.impl;

import org.apache.log4j.Logger;
import org.rebok2j.dao.*;
import org.rebok2j.models.Adapter;
import org.rebok2j.utils.DomainConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.LinkedHashMap;
import java.util.Map;

@Component
public class AdapterImpl implements Adapter {
  private static Logger log = Logger.getLogger(AdapterImpl.class);

  @Autowired
  private AuthorizationDao authorizationDao;

  @Autowired
  private CourierCompanyDao courierCompanyDao;

  @Autowired
  private DeliveryDao deliveryDao;

  @Autowired
  public DeliveryTypeDao deliveryTypeDao;

  @Autowired
  private IdTypeDao idTypeDao;

  @Autowired
  private LocationDao locationDao;

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
    AbstractDao dao = getDao(DomainConstants.DELIVERY_TYPE.ENTITY_NAME_FIELD);
    if (dao == null)
      log.error("!!!!!!!!!!!!!!!!! dao == null !!!!!!!!!!!!!!!!!!!!!!!");
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

  private AbstractDao getDao(String typeName) {

    return null;
  }
}
