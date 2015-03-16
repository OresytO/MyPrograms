package com.rebok3J.model;

import com.rebok3J.model.impl.User;

/**
 * Created by OrestO on 3/13/2015.
 */
public interface UserQueryHolder extends CommonQueryHolder
{
  public static final String FIND_ALL = "User.findAll";
  public static final String FIND_ALL_QUERY = "select u from " + User.USER_ENTITY + " u";

  // Params for Query
  public static final String NICKNAME = "nickname";
  public static final String FIND_BY_NICKNAME = "User.findByNickname";
  public static final String FIND_BY_NICKNAME_QUERY = "select entity from " + User.USER_ENTITY + " entity where entity.userNickname = :" + User.USER_NICKNAME_COLUMN;

  @Override
  String getFindAllQueryName();
}
