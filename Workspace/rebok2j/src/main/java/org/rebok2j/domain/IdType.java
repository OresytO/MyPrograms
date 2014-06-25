package org.rebok2j.domain;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

import static org.rebok2j.utils.DomainConstants.ID_TYPE;

@Entity
@Table(name = "IdTypes")
@NamedQueries({@NamedQuery(name = ID_TYPE.FIND_ALL, query = ID_TYPE.FIND_ALL_Q)})
public class IdType implements Serializable, Comparable<IdType> {

    private static final long serialVersionUID = -8981711113476946436L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long Id;

    @Column(name = "idName")
    private String idName;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "idType")
    private Set<CourierCompany> courierCompanies;

    /*-----------------------------------------------------------*/

    public IdType() {
    }

    public long getId() {
        return Id;
    }

    public void setId(long id) {
        Id = id;
    }

    public String getIdName() {
        return idName;
    }

    public void setIdName(String idName) {
        this.idName = idName;
    }

    public Set<CourierCompany> getCourierCompanies() {
        return courierCompanies;
    }

    public void setCourierCompanies(Set<CourierCompany> courierCompanies) {
        this.courierCompanies = courierCompanies;
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
        IdType other = (IdType) obj;
        if (Id != other.Id)
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "IdType [Id=" + Id + ", idName=" + idName + "]";
    }

    @Override
    public int compareTo(IdType o) {
        return this.getIdName().compareTo(o.getIdName());
    }

}
