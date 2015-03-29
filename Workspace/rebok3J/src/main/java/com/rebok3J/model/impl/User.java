package com.rebok3J.model.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.*;

import com.rebok3J.model.UserQueryHolder;

/**
 *
 *
 * @author OrestO
 * @since 3/11/2015
 */
@Entity
@Table(name = User.USER_TABLE)
@NamedQueries({ @NamedQuery(name = UserQueryHolder.FIND_ALL, query = UserQueryHolder.FIND_ALL_QUERY),
    @NamedQuery(name = UserQueryHolder.FIND_BY_NICKNAME, query = UserQueryHolder.FIND_BY_NICKNAME_QUERY) })
public class User implements UserQueryHolder, Serializable, Comparable<User>
{

  private static final long serialVersionUID = -7588331808777137405L;

  public static final String USER_ENTITY = "User";
  public static final String USER_TABLE = "\"user\"";

  @Id
  @SequenceGenerator(name = ID_SEQ, sequenceName = ID_SEQ, allocationSize = 1)
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = ID_SEQ)
  @Column(name = ID_COLUMN)
  private Long id;
  public static final String ID_COLUMN = "id";
  public static final String ID_SEQ = "user_id_seq";

  @Column(name = USER_NICKNAME_COLUMN, nullable = false)
  private String userNickname;
  public static final String USER_NICKNAME_COLUMN = "user_nickname";

  @Column(name = PASSWORD_COLUMN, nullable = false)
  private String password;
  public static final String PASSWORD_COLUMN = "password";

  @Column(name = USER_NAME_COLUMN, nullable = false)
  private String userName;
  public static final String USER_NAME_COLUMN = "user_name";

  @Column(name = ENABLE_COLUMN, nullable = false)
  private Boolean enabled;
  public static final String ENABLE_COLUMN = "enable";

  @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
  @JoinTable(name = USERS_ROLES_TABLE, joinColumns = { @JoinColumn(name = USER_ID_COLUMN, updatable = true, nullable = false) }, inverseJoinColumns = { @JoinColumn(name = ROLE_ID_COLUMN, updatable = true, nullable = false) })
  private List<Role> roles;

  public static final String USERS_ROLES_TABLE = "\"users_roles\"";
  public static final String USER_ID_COLUMN = "user_id";
  public static final String ROLE_ID_COLUMN = "role_id";

  @Temporal(TemporalType.TIMESTAMP)
  @Column(name = CREATE_DATE_COLUMN, nullable = false)
  private Date createDate;
  public static final String CREATE_DATE_COLUMN = "create_date";

  @Temporal(TemporalType.TIMESTAMP)
  @Column(name = LAST_UPDATE_TIMESTAMP_COLUMN, nullable = false)
  private Date lastUpdated;
  public static final String LAST_UPDATE_TIMESTAMP_COLUMN = "last_update_timestamp";

  /*-----------------------------------------------------------*/

  public User()
  {
  }

  public User(String userNickname, String password, String userName, Boolean enabled, List<Role> roles)
  {
    this.userNickname = userNickname;
    this.password = password;
    this.userName = userName;
    this.enabled = enabled;
    this.roles = roles;
  }

  public Date getCreateDate()
  {
    return createDate;
  }

  public void setCreateDate(Date createDate)
  {
    this.createDate = createDate;
  }

  public Boolean isEnabled()
  {
    return enabled;
  }

  public void setEnabled(Boolean enabled)
  {
    this.enabled = enabled;
  }

  public Long getId()
  {
    return id;
  }

  public void setId(Long id)
  {
    this.id = id;
  }

  public Date getLastUpdated()
  {
    return lastUpdated;
  }

  public void setLastUpdated(Date lastUpdated)
  {
    this.lastUpdated = lastUpdated;
  }

  public String getPassword()
  {
    return password;
  }

  public void setPassword(String password)
  {
    this.password = password;
  }

  public List<Role> getRoles()
  {
    return roles;
  }

  public void setRoles(List<Role> roles)
  {
    this.roles = roles;
  }

  public static long getSerialVersionUID()
  {
    return serialVersionUID;
  }

  public String getUserName()
  {
    return userName;
  }

  public void setUserName(String userName)
  {
    this.userName = userName;
  }

  public String getUserNickname()
  {
    return userNickname;
  }

  public void setUserNickname(String userNickname)
  {
    this.userNickname = userNickname;
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
    User other = (User) obj;
    return !userNickname.equalsIgnoreCase(other.userNickname);
  }

  @Override
  public String toString()
  {
    return "User [id=" + id + ", userName=" + userName + "]";
  }

  @Override
  public int compareTo(User o)
  {
    return this.getUserNickname().compareTo(o.getUserNickname());
  }

  @Override
  public String getFindAllQueryName()
  {
    return User.FIND_ALL;
  }

  @PrePersist
  public void createdTimestamp()
  {
    createDate = new Date();
  }

  @PreUpdate
  public void lastUpdatedTimestamp()
  {
    lastUpdated = new Date();
  }
}
