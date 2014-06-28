package org.rebok2j.domain;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

import static org.rebok2j.utils.DomainConstants.STAFF;

@Entity
@Table(name = "Staff")
@NamedQueries({@NamedQuery(name = STAFF.FIND_ALL, query = STAFF.FIND_ALL_Q)})
public class Staff implements Domain, Serializable, Comparable<Staff> {
    private static final long serialVersionUID = 1949287398495056789L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "firstName")
    private String firstName;

    @Column(name = "lastName")
    private String lastName;

    @Column(name = "passport")
    private String passport;

    @Column(name = "drivingLicense")
    private String drivingLicense;

    @Column(name = "powerToSign")
    private Boolean powerToSign;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "signedPerson")
    private Set<Authorization> authorizationsSigned;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "forwarder")
    private Set<Authorization> authorizationsAsForwarder;

    /*-----------------------------------------------------------*/

    public Staff() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    @SuppressWarnings("unused")
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    @SuppressWarnings("unused")
    public String getLastName() {
        return lastName;
    }

    @SuppressWarnings("unused")
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    @SuppressWarnings("unused")
    public String getPassport() {
        return passport;
    }

    @SuppressWarnings("unused")
    public void setPassport(String passport) {
        this.passport = passport;
    }

    @SuppressWarnings("unused")
    public String getDrivingLicense() {
        return drivingLicense;
    }

    @SuppressWarnings("unused")
    public void setDrivingLicense(String drivingLicense) {
        this.drivingLicense = drivingLicense;
    }

    @SuppressWarnings("unused")
    public Boolean getPowerToSign() {
        return powerToSign;
    }

    @SuppressWarnings("unused")
    public void setPowerToSign(Boolean powerToSign) {
        this.powerToSign = powerToSign;
    }

    @SuppressWarnings("unused")
    public Set<Authorization> getAuthorizationsSigned() {
        return authorizationsSigned;
    }

    @SuppressWarnings("unused")
    public void setAuthorizationsSigned(Set<Authorization> authorizationsSigned) {
        this.authorizationsSigned = authorizationsSigned;
    }

    @SuppressWarnings("unused")
    public Set<Authorization> getAuthorizationsAsForwarder() {
        return authorizationsAsForwarder;
    }

    @SuppressWarnings("unused")
    public void setAuthorizationsAsForwarder(Set<Authorization> authorizationsAsForwarder) {
        this.authorizationsAsForwarder = authorizationsAsForwarder;
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
        Staff other = (Staff) obj;
        return !id.equals(other.id);
    }

    @Override
    public String toString() {
        return "Staff [id=" + id + ", firstName=" + firstName + ", lastName=" + lastName + ", passport=" + passport + ", drivingLicense=" + drivingLicense
                + ", powerToSign=" + powerToSign + "]";
    }

    @Override
    public int compareTo(Staff o) {
        return this.getFirstName().compareTo(o.getFirstName());
    }

}
