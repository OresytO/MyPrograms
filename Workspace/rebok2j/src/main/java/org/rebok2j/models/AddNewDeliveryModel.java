package org.rebok2j.models;

public class AddNewDeliveryModel {

    private DropDownList deliveryType;
    private DropDownList departureDate;
    private DropDownList receiveDate;
    private DropDownList placeOfDeparture;
    private DropDownList courierCompany;
    private DropDownList contactPerson;
    private DropDownList weight;
    private DropDownList size;

    /*------------------------------*/

    public DropDownList getDeliveryType() {
        return deliveryType;
    }

    public void setDeliveryType(DropDownList deliveryType) {
        this.deliveryType = deliveryType;
    }

    public DropDownList getDepartureDate() {
        return departureDate;
    }

    public void setDepartureDate(DropDownList departureDate) {
        this.departureDate = departureDate;
    }

    public DropDownList getReceiveDate() {
        return receiveDate;
    }

    public void setReceiveDate(DropDownList receiveDate) {
        this.receiveDate = receiveDate;
    }

    public DropDownList getPlaceOfDeparture() {
        return placeOfDeparture;
    }

    public void setPlaceOfDeparture(DropDownList placeOfDeparture) {
        this.placeOfDeparture = placeOfDeparture;
    }

    public DropDownList getCourierCompany() {
        return courierCompany;
    }

    public void setCourierCompany(DropDownList courierCompany) {
        this.courierCompany = courierCompany;
    }

    public DropDownList getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(DropDownList contactPerson) {
        this.contactPerson = contactPerson;
    }

    public DropDownList getWeight() {
        return weight;
    }

    public void setWeight(DropDownList weight) {
        this.weight = weight;
    }

    public DropDownList getSize() {
        return size;
    }

    public void setSize(DropDownList size) {
        this.size = size;
    }

}
