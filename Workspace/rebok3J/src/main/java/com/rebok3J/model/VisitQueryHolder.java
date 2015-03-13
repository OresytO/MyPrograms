package com.rebok3J.model;

/**
 * Created by OrestO on 3/13/2015.
 */
public interface VisitQueryHolder extends CommonQueryHolder
{
  String VISIT_ENTITY = "VisitImpl";
  String VISIT_TABLE = "\"VISIT\"";
  String FIND_ALL = "Visit.findAll";
  String FIND_ALL_QUERY = "select u from " + VisitQueryHolder.VISIT_ENTITY + " u";

  @Override
  String getFindAll();
}
