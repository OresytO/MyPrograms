package org.rebok2j.domain;

import java.io.Serializable;

import javax.persistence.*;

@Entity
@Table(name = "Deliveries")
@NamedQueries({ @NamedQuery(name = "Delivery.findAll", query = "select d from Delivery d") })
public class Delivery implements Serializable, Comparable<Delivery> {

    private static final long serialVersionUID = -6048746691997605170L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long Id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "courierCompanyId", nullable = false)
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

    @Column(name = "received")
    private Boolean received;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "typeOfDeliveryId", nullable = false)
    private DeliveryType typeOfDelivery;

    @Column(name = "creationDate")
    private String creationDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "authorizationId", nullable = false)
    private Authorization authorization;

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

    public Boolean getReceived() {
        return received;
    }

    public void setReceived(Boolean received) {
        this.received = received;
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

    public Authorization getAuthorization() {
        return authorization;
    }

    public void setAuthorization(Authorization authorization) {
        this.authorization = authorization;
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
        return "Delivery [Id=" + Id + ", courierCompany=" + courierCompany + ", deliveryCode=" + deliveryCode + ", weight=" + weight + ", size=" + size
                + ", cost=" + cost + ", dateOfSending=" + dateOfSending + ", dateOfReceiving=" + dateOfReceiving + ", sended=" + sended + ", received="
                + received + ", typeOfDelivery=" + typeOfDelivery + ", creationDate=" + creationDate + "]";
    }

    @Override
    public int compareTo(Delivery o) {
        return this.getDeliveryCode().compareTo(o.getDeliveryCode());
    }

}
