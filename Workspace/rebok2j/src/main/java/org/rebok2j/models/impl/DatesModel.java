package org.rebok2j.models.impl;

import org.rebok2j.models.DropDown;

public class DatesModel {
    private DropDown departureDate;
    private DropDown receiveDate;

    public DropDown getDepartureDate() {
        return departureDate;
    }

    public void setDepartureDate(DropDown departureDate) {
        this.departureDate = departureDate;
    }

    public DropDown getReceiveDate() {
        return receiveDate;
    }

    public void setReceiveDate(DropDown receiveDate) {
        this.receiveDate = receiveDate;
    }

}
