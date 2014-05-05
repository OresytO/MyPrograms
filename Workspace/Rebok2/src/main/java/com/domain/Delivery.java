package com.domain;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import com.domain.City;
import com.domain.Status;

@Entity
@Table(name = "Deliveries")
public class Delivery implements Serializable {
    private static final long serialVersionUID = 8092829843047325133L;

    @Id
    @GeneratedValue
    private Long ID;

    @Column(name = "SendDate")
    private Date sendDate;

    @Column(name = "DeliveryDate")
    private Date deliveryDate;

    @Column(name = "DeliveryCost")
    private Double deliveryCost;

    @Column(name = "Place")
    private Integer place;

    @Column(name = "DeclarationCode")
    private String declarationCode;

    @Column(name = "ContactPerson")
    private String contactPerson;

    @Column(name = "Note")
    private String note;

    @Column(name = "Weight")
    private Double weight;

    @Column(name = "Size")
    private String size;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "Sender")
    private Contragent sender;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "Receiver")
    private Contragent receiver;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "Status")
    private Status status;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "DestinationPlace")
    private City destinationPlace;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "SenderPlace")
    private City senderPlace;
}
