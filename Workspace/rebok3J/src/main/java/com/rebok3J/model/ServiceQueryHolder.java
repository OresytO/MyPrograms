package com.rebok3J.model;

import static com.rebok3J.model.impl.Service.*;

/**
 *
 *
 * @author OrestO
 * @since 3/13/2015
 */
public interface ServiceQueryHolder extends CommonQueryHolder
{
  String FIND_ALL = SERVICE_ENTITY + CommonQueryHolder.FIND_ALL;
  String FIND_ALL_QUERY = "select e from " + SERVICE_ENTITY + " e";

  @Override
  String getFindAllQueryName();

  String GET_ALL_SERVICES_FOR_SELECT = SERVICE_ENTITY + ".getAllServicesForSelect";
  String GET_ALL_SERVICES_FOR_SELECT_QUERY = "select " + ID_COLUMN + ", " + NAME_COLUMN + "  from " + SERVICE_TABLE;

  String getAllServicesForSelect();
}
