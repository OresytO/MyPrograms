package com.rebok3J.model;

import static com.rebok3J.model.impl.User.USER_ENTITY;

/**
 *
 *
 * @author OrestO
 * @since 3/13/2015
 */
public interface UserQueryHolder extends CommonQueryHolder
{
  String FIND_ALL =  USER_ENTITY + CommonQueryHolder.FIND_ALL;
  String FIND_ALL_QUERY = "select e from " + USER_ENTITY + " e";

  // Params for Query
  String NICKNAME = "nickname";
  String FIND_BY_NICKNAME = USER_ENTITY + "." + NICKNAME;
  String FIND_BY_NICKNAME_QUERY = "select e from " + USER_ENTITY + " e where e.userNickname = :" + NICKNAME;

  @Override
  String getFindAllQueryName();
}
