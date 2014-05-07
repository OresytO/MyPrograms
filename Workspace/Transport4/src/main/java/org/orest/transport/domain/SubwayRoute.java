package org.orest.transport.domain;

import javax.persistence.Entity;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "subway_routes")
@NamedQuery(name = "SubwayRoute.findByName", query = "select s from SubwayRoute s where s.numOfRoute = ?1")
public class SubwayRoute extends Route {

}
