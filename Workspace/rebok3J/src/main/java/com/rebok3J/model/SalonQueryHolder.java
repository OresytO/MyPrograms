package com.rebok3J.model;

import static com.rebok3J.model.impl.Salon.SALON_ENTITY;

/**
 *
 *
 * @author OrestO
 * @since 3/13/2015
 */
public interface SalonQueryHolder extends CommonQueryHolder
{
  String FIND_ALL = SALON_ENTITY + CommonQueryHolder.FIND_ALL;
  String FIND_ALL_QUERY = "select e from " + SALON_ENTITY + " e";

  @Override
  String getFindAllQueryName();
}
