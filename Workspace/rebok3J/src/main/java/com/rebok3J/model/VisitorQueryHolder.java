package com.rebok3J.model;

import static com.rebok3J.model.impl.Visitor.VISITOR_ENTITY;

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
}
