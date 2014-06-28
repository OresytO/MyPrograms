package org.rebok2j.domain;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

import static org.rebok2j.utils.DomainConstants.AUTHORIZATION;

/**
 * Created by OrestO
 * on 6/28/2014.
 */
@Entity
@Table(name = "Authorizations")
@NamedQueries({@NamedQuery(name = AUTHORIZATION.FIND_ALL, query = AUTHORIZATION.FIND_ALL_Q)})
public class Authorization implements Domain, Serializable, Comparable<Authorization> {

    private static final long serialVersionUID = 7473471713802663734L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

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

    @Column(name = "dateOfAuthorization")
    private String dateofAuthorization;

    @Column(name = "creationDate")
    private String creationDate;

    /*-----------------------------------------------------------*/

    public Authorization() {
        super();
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @SuppressWarnings("unused")
    public Set<Delivery> getDeliveries() {
        return deliveries;
    }

    @SuppressWarnings("unused")
    public void setDeliveries(Set<Delivery> deliveries) {
        this.deliveries = deliveries;
    }

    @SuppressWarnings("unused")
    public Staff getSignedPerson() {
        return signedPerson;
    }

    @SuppressWarnings("unused")
    public void setSignedPerson(Staff signedPerson) {
        this.signedPerson = signedPerson;
    }

    @SuppressWarnings("unused")
    public Staff getForwarder() {
        return forwarder;
    }

    @SuppressWarnings("unused")
    public void setForwarder(Staff forwarder) {
        this.forwarder = forwarder;
    }

    @SuppressWarnings("unused")
    public String getAuthorizationCode() {
        return authorizationCode;
    }

    @SuppressWarnings("unused")
    public void setAuthorizationCode(String authorizationCode) {
        this.authorizationCode = authorizationCode;
    }

    @SuppressWarnings("unused")
    public String getDateofAuthorization() {
        return dateofAuthorization;
    }

    @SuppressWarnings("unused")
    public void setDateofAuthorization(String dateOfAuthorization) {
        this.dateofAuthorization = dateOfAuthorization;
    }

    @SuppressWarnings("unused")
    public String getCreationDate() {
        return creationDate;
    }

    @SuppressWarnings("unused")
    public void setCreationDate(String creationDate) {
        this.creationDate = creationDate;
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
        Authorization other = (Authorization) obj;
        return !id.equals(other.id);
    }

    @Override
    public String toString() {
        return "Authorization [id=" + id + ", deliveries=" + deliveries + ", signedPerson=" + signedPerson + ", forwarder=" + forwarder + ", authorizationCode="
                + authorizationCode + ", dateOfAuthorization=" + dateofAuthorization + ", creationDate=" + creationDate + "]";
    }

    @Override
    public int compareTo(Authorization authorization) {
        return this.getAuthorizationCode().compareTo(authorization.getAuthorizationCode());
    }

}
