package com.rebok3J.model;

import com.rebok3J.model.impl.Service;

/**
 * Created by OrestO on 3/13/2015.
 */
public interface ServiceQueryHolder extends CommonQueryHolder
{
  String FIND_ALL = "Service.findAll";
  String FIND_ALL_QUERY = "select u from " + Service.SERVICE_ENTITY + " u";

  @Override
  String getFindAllQueryName();
}
