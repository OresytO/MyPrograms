package com.rebok3J.model.impl;

import javax.persistence.*;

import com.rebok3J.model.UserQueryHolder;

/**
 * Created by OrestO on 3/11/2015.
 */
@Entity
@Table(name = UserQueryHolder.USER_TABLE)
@NamedQueries({ @NamedQuery(name = UserQueryHolder.FIND_ALL, query = UserQueryHolder.FIND_ALL_QUERY) })
public class UserImpl implements UserQueryHolder
{

  @Id
  @GeneratedValue
  @Column(name = ID_COLUMN)
  private long id;
  public static final String ID_COLUMN = "ID";

  @Column(name = NAME_COLUMN, nullable = false)
  private String name;
  public static final String NAME_COLUMN = "NAME";

  @Column(name = LOGIN_COLUMN, nullable = false, unique = true)
  private String login;
  public static final String LOGIN_COLUMN = "LOGIN";

  @Column(name = PASSWORD_COLUMN, nullable = false)
  private String password;
  public static final String PASSWORD_COLUMN = "PASSWORD";

  public String getName()
  {
    return name;
  }

  public void setName(String name)
  {
    this.name = name;
  }

  public String getLogin()
  {
    return login;
  }

  public void setLogin(String login)
  {
    this.login = login;
  }

  public String getPassword()
  {
    return password;
  }

  public void setPassword(String password)
  {
    this.password = password;
  }

  public long getId()
  {
    return id;
  }

  public void setId(long id)
  {
    this.id = id;
  }

  @Override
  public boolean equals(Object o)
  {
    if (this == o)
      return true;
    if (o == null || getClass() != o.getClass())
      return false;

    UserImpl user = (UserImpl) o;

    if (!login.equals(user.login))
      return false;
    if (!name.equals(user.name))
      return false;
    if (!password.equals(user.password))
      return false;

    return true;
  }

  @Override
  public int hashCode()
  {
    int result = name.hashCode();
    result = 31 * result + login.hashCode();
    result = 31 * result + password.hashCode();
    return result;
  }

  @Override
  public String toString()
  {
    return "UserImpl{" + "id=" + id + ", name='" + name + '\'' + ", login='" + login + '\'' + ", password='" + password + '\'' + '}';
  }

  @Override
  public String getFindAll()
  {
    return FIND_ALL;
  }
}
