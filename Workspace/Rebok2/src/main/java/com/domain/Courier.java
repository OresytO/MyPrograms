package com.domain;

import java.io.Serializable;
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
@Table(name = "Couriers")
public class Courier implements Serializable {
    private static final long serialVersionUID = 9161814325790539600L;

    @Id
    @GeneratedValue
    private Long ID;

    @Column(name = "NameAndStoregNumber")
    private String nameAndStoregNumber;

    @Column(name = "Address")
    private String address;

    @Column(name = "PhoneNumb1")
    private String phoneNumb1;

    @Column(name = "PhoneNumb2")
    private String phoneNumb2;

    @Column(name = "PhoneNumb3")
    private String phoneNumb3;

    @Column(name = "PassportAsID")
    private String passportAsID;

    @OneToMany(mappedBy = "senderPlace", fetch = FetchType.LAZY)
    private Set<Delivery> deliveries;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "Payment")
    private Payment payment;

}
