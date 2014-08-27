package org.rebok2j.models;

import java.util.Map;

/**
 * Created by OrestO
 * on 6/23/2014.
 */
/*This interface make easier to generate concrete model
* if you need to add some new type of model you need add
* it here as well.
* Be careful to add concrete Dao bean if you need one in
* implementation*/
public interface Adapter {

  @SuppressWarnings("unused")
  Adapter getAuthorizationModel(String attributeName);

  Adapter getCourierCompanyModel(String attributeName);

  @SuppressWarnings("unused")
  Adapter getDeliveryModel(String attributeName);

  Adapter getDeliveryTypeModel(String attributeName);

  @SuppressWarnings("unused")
  Adapter getIdTypeModel(String attributeName);

  Adapter getLocationModel(String attributeName);

  Map<String, Object> getModel();

  void setModel(Map<String, Object> model);
}
