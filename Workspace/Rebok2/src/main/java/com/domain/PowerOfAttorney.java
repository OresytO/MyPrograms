package com.domain;

import java.io.Serializable;
import java.sql.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "PowerOfAttorneis")
public class PowerOfAttorney implements Serializable {
    private static final long serialVersionUID = 3256304531452961090L;

    @Id
    @GeneratedValue
    private Long ID;

    @Column(name = "CreationDate")
    private Date creationDate;

    @Column(name = "Code")
    private String code;

    @OneToMany(mappedBy = "powerOfAttorney", fetch = FetchType.LAZY)
    private Set<Delivery> deliveries;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "SenderPlace")
    private City senderPlace;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "Forwarder")
    private Forwarder forwarder;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "SignedBy")
    private Forwarder signedBy;
}
