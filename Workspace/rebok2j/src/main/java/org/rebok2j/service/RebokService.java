package org.rebok2j.service;

import org.rebok2j.models.DropDownList;

public interface RebokService<T> {

    DropDownList fillDropDownList(String queryName) throws InstantiationException, IllegalAccessException;

}
