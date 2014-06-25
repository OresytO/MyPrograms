package org.rebok2j.domain;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

import static org.rebok2j.utils.DomainConstants.DELIVERY_TYPE;

@Entity
@Table(name = "DeliveriesTypes")
@NamedQueries({@NamedQuery(name = DELIVERY_TYPE.FIND_ALL, query = DELIVERY_TYPE.FIND_ALL_Q)})
public class DeliveryType implements Serializable, Comparable<DeliveryType> {

    private static final long serialVersionUID = 5420966512380043267L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long Id;

    @Column(name = "deliveryType")
    private String deliveryType;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "typeOfDelivery")
    private Set<Delivery> deliveries;

    /*-----------------------------------------------------------*/

    public DeliveryType() {
        super();
    }

    public long getId() {
        return Id;
    }

    public void setId(long id) {
        Id = id;
    }

    public String getDeliveryType() {
        return deliveryType;
    }

    public void setDeliveryType(String deliveryType) {
        this.deliveryType = deliveryType;
    }

    public Set<Delivery> getDeliveries() {
        return deliveries;
    }

    public void setDeliveries(Set<Delivery> deliveries) {
        this.deliveries = deliveries;
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
        DeliveryType other = (DeliveryType) obj;
        if (Id != other.Id)
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "DeliveryType [Id=" + Id + ", deliveryType=" + deliveryType + "]";
    }

    @Override
    public int compareTo(DeliveryType o) {
        return this.getDeliveryType().compareToIgnoreCase(o.getDeliveryType());
    }

}
