package com.rebok3J.model.impl;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.*;

/**
 * Created by OrestO on 3/13/2015.
 */
@Entity(name = Role.ROLE_ENTITY)
@Table(name = Role.ROLE_TABLE)
public class Role implements Serializable, Comparable<Role>
{

  private static final long serialVersionUID = -2982346171367786230L;

  public static final String ROLE_ENTITY = "Role";
  public static final String ROLE_TABLE = "\"ROLE\"";

  public static final String ROLE = "ROLE_";
  public static final String ADMIN = "ADMIN";
  public static final String ROLE_ADMIN = ROLE + ADMIN;
  public static final String DIRECTOR = "DIRECTOR";
  public static final String ROLE_DIRECTOR = ROLE + DIRECTOR;
  public static final String MANAGER = "MANAGER";
  public static final String ROLE_MANAGER = ROLE + MANAGER;

  @Id
  @GeneratedValue
  @Column(name = ID_COLUMN)
  private Long id;
  public static final String ID_COLUMN = "ID";

  @Column(name = ROLE_NAME_COLUMN, nullable = false)
  private String roleName;
  public static final String ROLE_NAME_COLUMN = "ROLE_NAME";

  @ManyToMany(mappedBy = "roles", fetch = FetchType.EAGER)
  private Set<User> users;

  /*-----------------------------------------------------------*/

  public Role()
  {
  }

  public Role(String roleName, Set<User> users)
  {
    this.roleName = roleName;
    this.users = users;
  }

  public Long getId()
  {
    return id;
  }

  public void setId(Long id)
  {
    this.id = id;
  }

  public String getRoleName()
  {
    return roleName;
  }

  @SuppressWarnings("unused")
  public void setRoleName(String roleName)
  {
    this.roleName = roleName;
  }

  @SuppressWarnings("unused")
  public Set<User> getUsers()
  {
    return users;
  }

  @SuppressWarnings("unused")
  public void setUsers(Set<User> users)
  {
    this.users = users;
  }

  @Override
  public int hashCode()
  {
    final int prime = 31;
    int result = 1;
    result = prime * result + (int) (id ^ (id >>> 32));
    return result;
  }

  @Override
  public boolean equals(Object obj)
  {
    if (this == obj)
      return true;
    if (obj == null)
      return false;
    if (getClass() != obj.getClass())
      return false;
    Role other = (Role) obj;
    return !id.equals(other.id);
  }

  @Override
  public String toString()
  {
    return "Role [id=" + id + ", roleName=" + roleName + "]";
  }

  @Override
  public int compareTo(Role o)
  {
    return this.getRoleName().compareTo(o.getRoleName());
  }

}
