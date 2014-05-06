package org.orest.transport.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "bus")
public class Bus extends Vehicle {

    public Bus() {
        super();
    }

    @Column(name = "something")
    private String something;

    public String getSomething() {
        return something;
    }

    public void setSomething(String something) {
        this.something = something;
    }

}
