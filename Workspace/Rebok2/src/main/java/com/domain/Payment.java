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
@Table(name = "Payments")
public class Payment implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue
    private Long ID;

    @Column(name = "TypeOfPayment")
    private String typeOfPayment;

    @OneToMany(mappedBy = "payment", fetch = FetchType.LAZY)
    private Set<Courier> Couriers;

}
