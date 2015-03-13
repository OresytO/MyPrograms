package com.rebok3J.model;

/**
 * Created by OrestO on 3/13/2015.
 */
public interface VisitorQueryHolder extends CommonQueryHolder
{
  String VISITOR_ENTITY = "VisitorImpl";
  String VISITOR_TABLE = "\"VISITOR\"";
  String FIND_ALL = "Visitor.findAll";
  String FIND_ALL_QUERY = "select u from " + VisitorQueryHolder.VISITOR_ENTITY + " u";

  @Override
  String getFindAll();
}
