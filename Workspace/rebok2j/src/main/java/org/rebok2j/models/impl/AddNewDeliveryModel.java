package org.rebok2j.models.impl;

import org.rebok2j.models.Adapter;
import org.rebok2j.models.MyModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("addNewDeliveryModel")
public class AddNewDeliveryModel implements MyModel {

    @Autowired
    private Adapter adapter;

    @Override
    public Map<String, Object> getModel() {
        adapter.getDeliveryTypeModel("allDeliveryTypes")
                .getLocationModel("allLocations")
                .getCourierCompanyModel("allCourierCompanies");
        return adapter.getModel();
    }
}
