package org.rebok2j.domain;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

import static org.rebok2j.utils.DomainConstants.ID_TYPE;

@Entity
@Table(name = "IdTypes")
@NamedQueries({@NamedQuery(name = ID_TYPE.FIND_ALL, query = ID_TYPE.FIND_ALL_Q)})
public class IdType implements Domain, Serializable, Comparable<IdType> {

    private static final long serialVersionUID = -8981711113476946436L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "idName")
    private String idName;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "idType")
    private Set<CourierCompany> courierCompanies;

    /*-----------------------------------------------------------*/

    public IdType() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getIdName() {
        return idName;
    }

    @SuppressWarnings("unused")
    public void setIdName(String idName) {
        this.idName = idName;
    }

    @SuppressWarnings("unused")
    public Set<CourierCompany> getCourierCompanies() {
        return courierCompanies;
    }

    @SuppressWarnings("unused")
    public void setCourierCompanies(Set<CourierCompany> courierCompanies) {
        this.courierCompanies = courierCompanies;
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
        IdType other = (IdType) obj;
        return !id.equals(other.id);
    }

    @Override
    public String toString() {
        return "IdType [id=" + id + ", idName=" + idName + "]";
    }

    @Override
    public int compareTo(IdType o) {
        return this.getIdName().compareTo(o.getIdName());
    }

}
