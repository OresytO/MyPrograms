package org.rebok2j.domain;

import javax.persistence.*;
import java.io.Serializable;

import static org.rebok2j.utils.DomainConstants.DELIVERY;

@Entity
@Table(name = "Deliveries")
@NamedQueries({@NamedQuery(name = DELIVERY.FIND_ALL, query = DELIVERY.FIND_ALL_Q)})
public class Delivery implements Domain, Serializable, Comparable<Delivery> {

    private static final long serialVersionUID = -6048746691997605170L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

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
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @SuppressWarnings("unused")
    public CourierCompany getCourierCompany() {
        return courierCompany;
    }

    @SuppressWarnings("unused")
    public void setCourierCompany(CourierCompany courierCompany) {
        this.courierCompany = courierCompany;
    }

    public String getDeliveryCode() {
        return deliveryCode;
    }

    @SuppressWarnings("unused")
    public void setDeliveryCode(String deliveryCode) {
        this.deliveryCode = deliveryCode;
    }

    @SuppressWarnings("unused")
    public Double getWeight() {
        return weight;
    }

    @SuppressWarnings("unused")
    public void setWeight(Double weight) {
        this.weight = weight;
    }

    @SuppressWarnings("unused")
    public String getSize() {
        return size;
    }

    @SuppressWarnings("unused")
    public void setSize(String size) {
        this.size = size;
    }

    @SuppressWarnings("unused")
    public Double getCost() {
        return cost;
    }

    @SuppressWarnings("unused")
    public void setCost(Double cost) {
        this.cost = cost;
    }

    @SuppressWarnings("unused")
    public String getDateOfSending() {
        return dateOfSending;
    }

    @SuppressWarnings("unused")
    public void setDateOfSending(String dateOfSending) {
        this.dateOfSending = dateOfSending;
    }

    @SuppressWarnings("unused")
    public String getDateOfReceiving() {
        return dateOfReceiving;
    }

    @SuppressWarnings("unused")
    public void setDateOfReceiving(String dateOfReceiving) {
        this.dateOfReceiving = dateOfReceiving;
    }

    @SuppressWarnings("unused")
    public Boolean getSended() {
        return sended;
    }

    @SuppressWarnings("unused")
    public void setSended(Boolean sended) {
        this.sended = sended;
    }

    @SuppressWarnings("unused")
    public Boolean getReceived() {
        return received;
    }

    @SuppressWarnings("unused")
    public void setReceived(Boolean received) {
        this.received = received;
    }

    @SuppressWarnings("unused")
    public DeliveryType getTypeOfDelivery() {
        return typeOfDelivery;
    }

    @SuppressWarnings("unused")
    public void setTypeOfDelivery(DeliveryType typeOfDelivery) {
        this.typeOfDelivery = typeOfDelivery;
    }

    @SuppressWarnings("unused")
    public String getCreationDate() {
        return creationDate;
    }

    @SuppressWarnings("unused")
    public void setCreationDate(String creationDate) {
        this.creationDate = creationDate;
    }

    @SuppressWarnings("unused")
    public Authorization getAuthorization() {
        return authorization;
    }

    @SuppressWarnings("unused")
    public void setAuthorization(Authorization authorization) {
        this.authorization = authorization;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + (int) (id ^ (id >>> 32));
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
        return !id.equals(other.id);
    }

    @Override
    public String toString() {
        return "Delivery [id=" + id + ", courierCompany=" + courierCompany + ", deliveryCode=" + deliveryCode + ", weight=" + weight + ", size=" + size
                + ", cost=" + cost + ", dateOfSending=" + dateOfSending + ", dateOfReceiving=" + dateOfReceiving + ", sended=" + sended + ", received="
                + received + ", typeOfDelivery=" + typeOfDelivery + ", creationDate=" + creationDate + "]";
    }

    @Override
    public int compareTo(Delivery o) {
        return this.getDeliveryCode().compareTo(o.getDeliveryCode());
    }

}
