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
@Table(name = "Autorizations")
public class Autorization implements Serializable {

    private static final long serialVersionUID = 7473471713802663734L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long Id;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "autorization")
    private Set<Delivery> deliveries;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "signedPersonId", nullable = false)
    private Staff signedPerson;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "forwarderId", nullable = false)
    private Staff forwarder;

    @Column(name = "autorizationCode")
    private String autorizationCode;

    @Column(name = "dateofAutorization")
    private String dateofAutorization;

    @Column(name = "creationDate")
    private String creationDate;

    /*-----------------------------------------------------------*/

    public Autorization() {
        super();
    }

    public long getId() {
        return Id;
    }

    public void setId(long id) {
        Id = id;
    }

    public Set<Delivery> getDeliveries() {
        return deliveries;
    }

    public void setDeliveries(Set<Delivery> deliveries) {
        this.deliveries = deliveries;
    }

    public Staff getSignedPerson() {
        return signedPerson;
    }

    public void setSignedPerson(Staff signedPerson) {
        this.signedPerson = signedPerson;
    }

    public Staff getForwarder() {
        return forwarder;
    }

    public void setForwarder(Staff forwarder) {
        this.forwarder = forwarder;
    }

    public String getAutorizationCode() {
        return autorizationCode;
    }

    public void setAutorizationCode(String autorizationCode) {
        this.autorizationCode = autorizationCode;
    }

    public String getDateofAutorization() {
        return dateofAutorization;
    }

    public void setDateofAutorization(String dateofAutorization) {
        this.dateofAutorization = dateofAutorization;
    }

    public String getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(String creationDate) {
        this.creationDate = creationDate;
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
        Autorization other = (Autorization) obj;
        if (Id != other.Id)
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "Autorization [Id=" + Id + ", deliveries=" + deliveries + ", signedPerson=" + signedPerson + ", forwarder=" + forwarder + ", autorizationCode="
                + autorizationCode + ", dateofAutorization=" + dateofAutorization + ", creationDate=" + creationDate + "]";
    }

}
