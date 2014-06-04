package org.rebok2j.domain;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "CourierCompanies")
public class CourierCompany implements Serializable, Comparable<CourierCompany> {
    private static final long serialVersionUID = -8599566022985360241L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long Id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idType", nullable = false)
    private IdType idType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "location", nullable = false)
    private Location location;

    @Column(name = "companyName")
    private String companyName;

    @Column(name = "warehouseCode")
    private String warehouseCode;

    @Column(name = "address")
    private String address;

    @Column(name = "phones")
    private String phones;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "courierCompany")
    private Set<Delivery> deliveries;

    /*-----------------------------------------------------------*/

    public CourierCompany() {
    }

    public long getId() {
        return Id;
    }

    public void setId(long id) {
        Id = id;
    }

    public IdType getIdType() {
        return idType;
    }

    public void setIdType(IdType idType) {
        this.idType = idType;
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getWarehouseCode() {
        return warehouseCode;
    }

    public void setWarehouseCode(String warehouseCode) {
        this.warehouseCode = warehouseCode;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhones() {
        return phones;
    }

    public void setPhones(String phones) {
        this.phones = phones;
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
        CourierCompany other = (CourierCompany) obj;
        if (Id != other.Id)
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "CourierCompany [Id=" + Id + ", idType=" + idType + ", location=" + location + ", companyName=" + companyName + ", warehouseCode="
                + warehouseCode + ", address=" + address + ", phones=" + phones + "]";
    }

    @Override
    public int compareTo(CourierCompany o) {
        return this.getCompanyName().compareTo(o.getCompanyName());
    }

}
