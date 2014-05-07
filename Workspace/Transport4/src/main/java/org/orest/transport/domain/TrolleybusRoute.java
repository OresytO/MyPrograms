package org.orest.transport.domain;

import javax.persistence.Entity;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "trolleybus_routes")
@NamedQuery(name = "TrolleybusRoute.findByName", query = "select t from TrolleybusRoute t where t.numOfRoute = ?1")
public class TrolleybusRoute extends Route {

}
