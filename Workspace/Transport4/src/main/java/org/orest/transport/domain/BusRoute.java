package org.orest.transport.domain;

import javax.persistence.Entity;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "bus_routes")
@NamedQuery(name = "BusRoute.findByName", query = "select b from BusRoute b where b.numOfRoute = ?1")
public class BusRoute extends Route {

}
