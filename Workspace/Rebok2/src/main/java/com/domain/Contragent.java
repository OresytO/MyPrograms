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
@Table(name = "Contragents")
public class Contragent implements Serializable {
    private static final long serialVersionUID = 7706174449192537923L;

    @Id
    @GeneratedValue
    private Long ID;

    @Column(name = "Name")
    private String name;

    @Column(name = "Address")
    private String address;

    @Column(name = "PhoneNumber1")
    private String phoneNumber1;

    @Column(name = "PhoneNumber2")
    private String phoneNumber2;

    @OneToMany(mappedBy = "sender", fetch = FetchType.LAZY)
    private Set<Delivery> senders;

    @OneToMany(mappedBy = "receiver", fetch = FetchType.LAZY)
    private Set<Delivery> Receivers;
}
