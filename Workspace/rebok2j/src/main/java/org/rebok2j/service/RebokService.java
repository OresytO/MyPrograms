package org.rebok2j.service;

import org.rebok2j.models.DropDownList;

public interface RebokService {

    DropDownList fillDropDownList(String queryName) throws InstantiationException, IllegalAccessException;

}
