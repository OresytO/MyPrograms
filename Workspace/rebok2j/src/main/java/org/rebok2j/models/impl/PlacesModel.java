package org.rebok2j.models.impl;

import org.rebok2j.models.DropDown;

public class PlacesModel {
    private DropDown placeOfDeparture;
    private DropDown placeOfReceiving;

    public DropDown getPlaceOfDeparture() {
        return placeOfDeparture;
    }

    public void setPlaceOfDeparture(DropDown placeOfDeparture) {
        this.placeOfDeparture = placeOfDeparture;
    }

    public DropDown getPlaceOfReceiving() {
        return placeOfReceiving;
    }

    public void setPlaceOfReceiving(DropDown placeOfReceiving) {
        this.placeOfReceiving = placeOfReceiving;
    }

}
