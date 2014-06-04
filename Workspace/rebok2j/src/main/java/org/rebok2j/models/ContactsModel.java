package org.rebok2j.models;

public class ContactsModel {
    private DropDownList courierCompany;
    private DropDownList contactPerson;

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

}
