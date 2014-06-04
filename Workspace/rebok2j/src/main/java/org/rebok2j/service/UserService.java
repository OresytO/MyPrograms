package org.rebok2j.service;

import org.rebok2j.models.DropDownList;

public interface UserService {

    DropDownList fillDropDownList() throws InstantiationException, IllegalAccessException;

}
