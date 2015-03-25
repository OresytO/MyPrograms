package com.rebok3J.model;

import static com.rebok3J.model.impl.Service.SERVICE_ENTITY;

/**
 *
 *
 * @author OrestO
 * @since 3/13/2015
 */
public interface ServiceQueryHolder extends CommonQueryHolder
{
  String FIND_ALL =  SERVICE_ENTITY + CommonQueryHolder.FIND_ALL;
  String FIND_ALL_QUERY = "select e from " + SERVICE_ENTITY + " e";

  @Override
  String getFindAllQueryName();
}
