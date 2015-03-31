package com.rebok3J.model.impl;

import java.util.Set;

import javax.annotation.Nonnull;
import javax.persistence.*;

import com.rebok3J.model.ModelObjectImpl;

/**
 *
 *
 * @author OrestO
 * @since 3/13/2015
 */
@Entity(name = Role.ROLE_ENTITY)
@Table(name = Role.ROLE_TABLE)
public class Role extends ModelObjectImpl<Role>
{

  private static final long serialVersionUID = 1L;

  public static final String ROLE_ENTITY = "Role";
  public static final String ROLE_TABLE = "\"role\"";

  public static final String ROLE = "ROLE_";
  public static final String ADMIN = "ADMIN";
  public static final String ROLE_ADMIN = ROLE + ADMIN;
  public static final String DIRECTOR = "DIRECTOR";
  public static final String ROLE_DIRECTOR = ROLE + DIRECTOR;
  public static final String MANAGER = "MANAGER";
  public static final String ROLE_MANAGER = ROLE + MANAGER;

  @Id
  @SequenceGenerator(name = ID_SEQ, sequenceName = ID_SEQ, allocationSize = 1)
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = ID_SEQ)
  @Column(name = ID_COLUMN)
  private Long id;
  public static final String ID_COLUMN = "id";
  public static final String ID_SEQ = "role_id_seq";

  @Column(name = ROLE_NAME_COLUMN, nullable = false)
  private String roleName;
  public static final String ROLE_NAME_COLUMN = "role_name";

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

  public void setRoleName(String roleName)
  {
    this.roleName = roleName;
  }

  public Set<User> getUsers()
  {
    return users;
  }

  public void setUsers(Set<User> users)
  {
    this.users = users;
  }

  @Override
  public int hashCode()
  {
    return super.hashCode(id);
  }

  @Override
  public boolean equals(Object obj)
  {
    return obj instanceof Role && super.equals(this, (Role) obj);
  }

  @Override
  public String toString()
  {
    return "Role [id=" + id + ", roleName=" + roleName + "]";
  }

  @Override
  public int compareTo(@Nonnull Role obj)
  {
    return this.getRoleName().compareTo(obj.getRoleName());
  }

}
