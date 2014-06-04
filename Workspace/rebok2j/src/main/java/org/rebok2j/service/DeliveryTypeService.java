package org.rebok2j.service;

import org.rebok2j.models.DropDownList;

public interface DeliveryTypeService {

    DropDownList fillDropDownList() throws InstantiationException, IllegalAccessException;

}
