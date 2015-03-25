package com.rebok3J.model;

import static com.rebok3J.model.impl.Visit.VISIT_ENTITY;

/**
 *
 *
 * @author OrestO
 * @since 3/13/2015
 */
public interface VisitQueryHolder extends CommonQueryHolder
{
  String FIND_ALL = VISIT_ENTITY + CommonQueryHolder.FIND_ALL;
  String FIND_ALL_QUERY = "select u from " + VISIT_ENTITY + " u";

  @Override
  String getFindAllQueryName();
}
