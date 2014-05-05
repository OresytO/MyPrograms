package com.domain;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "Forwarders")
public class Forwarder implements Serializable {
    private static final long serialVersionUID = -3582836242121199840L;

    @Id
    @GeneratedValue
    private Long ID;

    @Column(name = "Name")
    private String name;

    @Column(name = "PassportCodeAndNumb")
    private String passportCodeAndNumb;

    @Column(name = "DrivingLiceCodeAndNumb")
    private String drivingLiceCodeAndNumb;

    @Column(name = "JobTitle")
    private String jobTitle;

    @Column(name = "Sign")
    private Boolean sign;

    @OneToMany(mappedBy = "forwarder", fetch = FetchType.LAZY)
    private Set<PowerOfAttorney> PowerOfAttorney;

    @OneToMany(mappedBy = "signedBy", fetch = FetchType.LAZY)
    private Set<PowerOfAttorney> PowerOfAttorneySignedBy;

}
