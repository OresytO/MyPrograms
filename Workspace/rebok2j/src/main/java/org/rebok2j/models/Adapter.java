package org.rebok2j.models;

import java.util.Map;

/**
 * Created by OrestO on 6/23/2014.
 */
public interface Adapter {
    Adapter getAuthorizationModel(String attributeName);

    Adapter getCourierCompanyModel(String attributeName);

    Adapter getDeliveryModel(String attributeName);

    Adapter getDeliveryTypeModel(String attributeName);

    Adapter getIdTypeModel(String attributeName);

    Adapter getLocationModel(String attributeName);

    Map<String, Object> getModel();

    void setModel(Map<String, Object> model);
}
