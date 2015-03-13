package com.rebok3J.model;

import com.rebok3J.model.impl.Visitor;

/**
 * Created by OrestO on 3/13/2015.
 */
public interface VisitorQueryHolder extends CommonQueryHolder
{
  String FIND_ALL = "Visitor.findAll";
  String FIND_ALL_QUERY = "select u from " + Visitor.VISITOR_ENTITY + " u";

  @Override
  String getFindAll();
}
