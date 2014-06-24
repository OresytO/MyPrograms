package org.rebok2j.models.impl;

import org.rebok2j.models.Adapter;
import org.rebok2j.models.MyModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

@Service("AddNewDeliveryModel")
public class AddNewDeliveryModel implements MyModel {

    @Autowired
    private Adapter adapter;

    @Override
    public Model getModel() {
        adapter.getDeliveryTypeModel("deliveryType")
                .getLocationModel("placeOfReceiving")
                .getLocationModel("placeOfDeparture")
                .getCourierCompanyModel("courierCompany");
        return adapter.getModel();
    }
}
