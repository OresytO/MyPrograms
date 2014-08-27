package org.rebok2j.domain;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

import static org.rebok2j.utils.DomainConstants.COURIER_COMPANY;

@Entity
@Table(name = "CourierCompanies")
@NamedQueries({@NamedQuery(name = COURIER_COMPANY.FIND_ALL, query = COURIER_COMPANY.FIND_ALL_Q)})
public class CourierCompany implements Domain, Serializable, Comparable<CourierCompany> {
  private static final long serialVersionUID = -8599566022985360241L;

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id")
  private Long id;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "idTypeId", nullable = false)
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
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }

  @SuppressWarnings("unused")
  public IdType getIdType() {
    return idType;
  }

  @SuppressWarnings("unused")
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

  @SuppressWarnings("unused")
  public void setCompanyName(String companyName) {
    this.companyName = companyName;
  }

  @SuppressWarnings("unused")
  public String getWarehouseCode() {
    return warehouseCode;
  }

  @SuppressWarnings("unused")
  public void setWarehouseCode(String warehouseCode) {
    this.warehouseCode = warehouseCode;
  }

  @SuppressWarnings("unused")
  public String getAddress() {
    return address;
  }

  @SuppressWarnings("unused")
  public void setAddress(String address) {
    this.address = address;
  }

  @SuppressWarnings("unused")
  public String getPhones() {
    return phones;
  }

  @SuppressWarnings("unused")
  public void setPhones(String phones) {
    this.phones = phones;
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
    CourierCompany other = (CourierCompany) obj;
    return !id.equals(other.id);
  }

  @Override
  public String toString() {
    return "CourierCompany [id=" + id + ", idType=" + idType + ", location=" + location + ", companyName=" + companyName + ", warehouseCode="
      + warehouseCode + ", address=" + address + ", phones=" + phones + "]";
  }

  @Override
  public int compareTo(CourierCompany o) {
    return this.getCompanyName().compareTo(o.getCompanyName());
  }

}
