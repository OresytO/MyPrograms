package org.rebok2j.domain;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "Staff")
public class Staff implements Serializable, Comparable<Staff> {
    private static final long serialVersionUID = 1949287398495056789L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long Id;

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
    private Set<Autorization> authorizationsSigned;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "forwarder")
    private Set<Autorization> authorizationsAsForwarder;

    /*-----------------------------------------------------------*/

    public Staff() {
    }

    public long getId() {
        return Id;
    }

    public void setId(long id) {
        Id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPassport() {
        return passport;
    }

    public void setPassport(String passport) {
        this.passport = passport;
    }

    public String getDrivingLicense() {
        return drivingLicense;
    }

    public void setDrivingLicense(String drivingLicense) {
        this.drivingLicense = drivingLicense;
    }

    public Boolean getPowerToSign() {
        return powerToSign;
    }

    public void setPowerToSign(Boolean powerToSign) {
        this.powerToSign = powerToSign;
    }

    public Set<Autorization> getAuthorizationsSigned() {
        return authorizationsSigned;
    }

    public void setAuthorizationsSigned(Set<Autorization> authorizationsSigned) {
        this.authorizationsSigned = authorizationsSigned;
    }

    public Set<Autorization> getAuthorizationsAsForwarder() {
        return authorizationsAsForwarder;
    }

    public void setAuthorizationsAsForwarder(Set<Autorization> authorizationsAsForwarder) {
        this.authorizationsAsForwarder = authorizationsAsForwarder;
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
        Staff other = (Staff) obj;
        if (Id != other.Id)
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "Staff [Id=" + Id + ", firstName=" + firstName + ", lastName=" + lastName + ", passport=" + passport + ", drivingLicense=" + drivingLicense
                + ", powerToSign=" + powerToSign + "]";
    }

    @Override
    public int compareTo(Staff o) {
        return this.getFirstName().compareTo(o.getFirstName());
    }

}
