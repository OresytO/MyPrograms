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
@Table(name = "Cities")
public class City implements Serializable {
    private static final long serialVersionUID = 538068645769916310L;

    @Id
    @GeneratedValue
    private Long ID;

    @Column(name = "Name")
    private String name;

    @Column(name = "ZipCode")
    private String zipCode;

    @OneToMany(mappedBy = "destinationPlace", fetch = FetchType.LAZY)
    private Set<Delivery> destinationPlaceDeliveries;

    @OneToMany(mappedBy = "senderPlace", fetch = FetchType.LAZY)
    private Set<Delivery> senderPlaceDeliveries;
}
