package org.rebok2j.models;

public class AddNewDeliveryModel {
    private DeliveryTypeModel deliveryTypeModel;
    private DatesModel datesModel;
    private PlacesModel placesModel;
    private ContactsModel contactsModel;
    private SizeAndWeightModel sizeAndWeightModel;

    public DeliveryTypeModel getDeliveryTypeModel() {
        return deliveryTypeModel;
    }

    public void setDeliveryTypeModel(DeliveryTypeModel deliveryTypeModel) {
        this.deliveryTypeModel = deliveryTypeModel;
    }

    public DatesModel getDatesModel() {
        return datesModel;
    }

    public void setDatesModel(DatesModel datesModel) {
        this.datesModel = datesModel;
    }

    public PlacesModel getPlacesModel() {
        return placesModel;
    }

    public void setPlacesModel(PlacesModel placesModel) {
        this.placesModel = placesModel;
    }

    public ContactsModel getContactsModel() {
        return contactsModel;
    }

    public void setContactsModel(ContactsModel contactsModel) {
        this.contactsModel = contactsModel;
    }

    public SizeAndWeightModel getSizeAndWeightModel() {
        return sizeAndWeightModel;
    }

    public void setSizeAndWeightModel(SizeAndWeightModel sizeAndWeightModel) {
        this.sizeAndWeightModel = sizeAndWeightModel;
    }

}
