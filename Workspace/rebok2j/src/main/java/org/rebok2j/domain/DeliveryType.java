package org.rebok2j.domain;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

import static org.rebok2j.utils.DomainConstants.DELIVERY_TYPE;

@Entity
@Table(name = "DeliveriesTypes")
@NamedQueries({@NamedQuery(name = DELIVERY_TYPE.FIND_ALL, query = DELIVERY_TYPE.FIND_ALL_Q)})
public class DeliveryType implements Domain, Serializable, Comparable<DeliveryType> {

    private static final long serialVersionUID = 5420966512380043267L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "type")
    private String type;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "typeOfDelivery")
    private Set<Delivery> deliveries;

    /*-----------------------------------------------------------*/

    public DeliveryType() {
        super();
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @SuppressWarnings("unused")
    public Set<Delivery> getDeliveries() {
        return deliveries;
    }

    @SuppressWarnings("unused")
    public void setDeliveries(Set<Delivery> deliveries) {
        this.deliveries = deliveries;
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
        DeliveryType other = (DeliveryType) obj;
        return !id.equals(other.id);
    }

    @Override
    public String toString() {
        return "DeliveryType [id=" + id + ", type=" + type + "]";
    }

    @Override
    public int compareTo(DeliveryType o) {
        return this.getType().compareToIgnoreCase(o.getType());
    }

}
