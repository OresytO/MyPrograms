package com.rebok3J.model;

import static com.rebok3J.model.impl.Visitor.*;

/**
 *
 *
 * @author OrestO
 * @since 3/13/2015
 */
public interface VisitorQueryHolder extends CommonQueryHolder
{
  String FIND_ALL = VISITOR_ENTITY + CommonQueryHolder.FIND_ALL;
  String FIND_ALL_QUERY = "select e from " + VISITOR_ENTITY + " e";

  @Override
  String getFindAllQueryName();

  String GET_ALL_VISITORS_FOR_SELECT = VISITOR_ENTITY + ".getAllVisitorsForSelect";
  String GET_ALL_VISITORS_FOR_SELECT_QUERY = "select " + ID_COLUMN + ", " + LAST_NAME_COLUMN + ", " + FIRST_NAME_COLUMN + ", " + MIDDLE_NAME_COLUMN + "  from " + VISITOR_TABLE;

  String getAllServicesForSelect();
}
