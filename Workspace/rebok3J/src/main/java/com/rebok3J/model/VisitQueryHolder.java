package com.rebok3J.model;

import com.rebok3J.model.impl.Visit;

/**
 * Created by OrestO on 3/13/2015.
 */
public interface VisitQueryHolder extends CommonQueryHolder
{
  String FIND_ALL = "Visit.findAll";
  String FIND_ALL_QUERY = "select u from " + Visit.VISIT_ENTITY + " u";

  @Override
  String getFindAll();
}
