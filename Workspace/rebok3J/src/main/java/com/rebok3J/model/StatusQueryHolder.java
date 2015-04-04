package com.rebok3J.model;

import static com.rebok3J.model.impl.Status.STATUS_ENTITY;

/**
 *
 *
 * @author OrestO
 * @since 3/13/2015
 */
public interface StatusQueryHolder extends CommonQueryHolder
{
  String FIND_ALL = STATUS_ENTITY + CommonQueryHolder.FIND_ALL;
  String FIND_ALL_QUERY = "select e from " + STATUS_ENTITY + " e";

  @Override
  String getFindAllQueryName();
}
