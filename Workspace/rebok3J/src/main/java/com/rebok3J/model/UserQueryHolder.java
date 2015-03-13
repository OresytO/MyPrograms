package com.rebok3J.model;

/**
 * Created by OrestO on 3/13/2015.
 */
public interface UserQueryHolder extends CommonQueryHolder
{
  public static final String USER_ENTITY = "UserImpl";
  public static final String USER_TABLE = "\"USER\"";

  public static final String FIND_ALL = "User.findAll";
  public static final String FIND_ALL_QUERY = "select u from " + USER_ENTITY + " u";

  @Override
  String getFindAll();
}
