package org.rebok2j.domain;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

import static org.rebok2j.utils.DomainConstants.AUTHORIZATION;

@Entity
@Table(name = "Authorizations")
@NamedQueries({@NamedQuery(name = AUTHORIZATION.FIND_ALL, query = AUTHORIZATION.FIND_ALL_Q)})
public class Authorization implements Serializable, Comparable<Authorization> {

    private static final long serialVersionUID = 7473471713802663734L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long Id;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "authorization")
    private Set<Delivery> deliveries;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "signedPersonId", nullable = false)
    private Staff signedPerson;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "forwarderId", nullable = false)
    private Staff forwarder;

    @Column(name = "authorizationCode")
    private String authorizationCode;

    @Column(name = "dateofAuthorization")
    private String dateofAuthorization;

    @Column(name = "creationDate")
    private String creationDate;

    /*-----------------------------------------------------------*/

    public Authorization() {
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

    public String getAuthorizationCode() {
        return authorizationCode;
    }

    public void setAuthorizationCode(String authorizationCode) {
        this.authorizationCode = authorizationCode;
    }

    public String getDateofAuthorization() {
        return dateofAuthorization;
    }

    public void setDateofAuthorization(String dateofAuthorization) {
        this.dateofAuthorization = dateofAuthorization;
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
        Authorization other = (Authorization) obj;
        if (Id != other.Id)
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "Authorization [Id=" + Id + ", deliveries=" + deliveries + ", signedPerson=" + signedPerson + ", forwarder=" + forwarder + ", authorizationCode="
                + authorizationCode + ", dateofAuthorization=" + dateofAuthorization + ", creationDate=" + creationDate + "]";
    }

    @Override
    public int compareTo(Authorization o) {
        return this.getAuthorizationCode().compareTo(o.getAuthorizationCode());
    }

}
