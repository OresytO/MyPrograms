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
@Table(name = "Status")
public class Status implements Serializable {
    private static final long serialVersionUID = 149453541103637253L;

    @Id
    @GeneratedValue
    private Long ID;

    @Column(name = "Status")
    private String status;

    @OneToMany(mappedBy = "status", fetch = FetchType.LAZY)
    private Set<Delivery> deliveries;
}
