package org.orest.transport.domain;

import javax.persistence.Entity;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "tramway_routes")
@NamedQuery(name = "TramwayRoute.findByName", query = "select t from TramwayRoute t where t.numOfRoute = ?1")
public class TramwayRoute extends Route {

}
