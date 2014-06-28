package org.rebok2j.models.impl;

import org.rebok2j.models.Adapter;
import org.rebok2j.models.MyModel;
import org.rebok2j.utils.Components;
import org.rebok2j.utils.WebConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service(Components.ADD_NEW_DELIVERY_MODEL)
public class AddNewDeliveryModel implements MyModel {

  @Autowired
  private Adapter adapter;

  @Override
  public Map<String, Object> getModel() {
    adapter.getDeliveryTypeModel(WebConstants.ALL_DELIVERY_TYPES)
      .getLocationModel(WebConstants.ALL_LOCATIONS)
      .getCourierCompanyModel(WebConstants.ALL_COURIER_COMPANIES);
    return adapter.getModel();
  }
}
