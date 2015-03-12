package com.rebok3J.model;

/**
 * Created by OrestO on 3/11/2015.
 */
public interface User
{
  String getName();

  void setName(String name);

  String getLogin();

  void setLogin(String login);

  String getPassword();

  void setPassword(String password);

  long getId();

  void setId(long id);
}
