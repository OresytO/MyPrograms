package org.rebok2j.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "Deliveries")
public class Delivery {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long Id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "courierCompany", nullable = false)
    private CourierCompany courierCompany;

    @Column(name = "deliveryCode")
    private String deliveryCode;

    @Column(name = "weight")
    private Double weight;

    @Column(name = "size")
    private String size;

    @Column(name = "cost")
    private Double cost;

    @Column(name = "dateOfSending")
    private String dateOfSending;

    @Column(name = "dateOfReceiving")
    private String dateOfReceiving;

    @Column(name = "sended")
    private Boolean sended;

    @Column(name = "recieved")
    private Boolean recieved;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "typeOfDelivery", nullable = false)
    private DeliveryType typeOfDelivery;

    @Column(name = "creationDate")
    private String creationDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "autorization", nullable = false)
    private Autorization autorization;

    /*-----------------------------------------------------------*/

    public Delivery() {
    }

    public long getId() {
        return Id;
    }

    public void setId(long id) {
        Id = id;
    }

    public CourierCompany getCourierCompany() {
        return courierCompany;
    }

    public void setCourierCompany(CourierCompany courierCompany) {
        this.courierCompany = courierCompany;
    }

    public String getDeliveryCode() {
        return deliveryCode;
    }

    public void setDeliveryCode(String deliveryCode) {
        this.deliveryCode = deliveryCode;
    }

    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public Double getCost() {
        return cost;
    }

    public void setCost(Double cost) {
        this.cost = cost;
    }

    public String getDateOfSending() {
        return dateOfSending;
    }

    public void setDateOfSending(String dateOfSending) {
        this.dateOfSending = dateOfSending;
    }

    public String getDateOfReceiving() {
        return dateOfReceiving;
    }

    public void setDateOfReceiving(String dateOfReceiving) {
        this.dateOfReceiving = dateOfReceiving;
    }

    public Boolean getSended() {
        return sended;
    }

    public void setSended(Boolean sended) {
        this.sended = sended;
    }

    public Boolean getRecieved() {
        return recieved;
    }

    public void setRecieved(Boolean recieved) {
        this.recieved = recieved;
    }

    public DeliveryType getTypeOfDelivery() {
        return typeOfDelivery;
    }

    public void setTypeOfDelivery(DeliveryType typeOfDelivery) {
        this.typeOfDelivery = typeOfDelivery;
    }

    public String getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(String creationDate) {
        this.creationDate = creationDate;
    }

    public Autorization getAutorization() {
        return autorization;
    }

    public void setAutorization(Autorization autorization) {
        this.autorization = autorization;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + (int) (Id ^ (Id >>> 32));
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Delivery other = (Delivery) obj;
        if (Id != other.Id)
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "Delivery [Id=" + Id + ", courierCompany=" + courierCompany + ", deliveryCode=" + deliveryCode + ", weight=" + weight + ", size=" + size + ", cost=" + cost
                + ", dateOfSending=" + dateOfSending + ", dateOfReceiving=" + dateOfReceiving + ", sended=" + sended + ", recieved=" + recieved + ", typeOfDelivery="
                + typeOfDelivery + ", creationDate=" + creationDate + "]";
    }

}
