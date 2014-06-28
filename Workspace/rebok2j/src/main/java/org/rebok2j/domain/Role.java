package org.rebok2j.domain;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

@Entity
@Table(name = "Roles")
public class Role implements Domain, Serializable, Comparable<Role> {

  private static final long serialVersionUID = -2982346171367786230L;

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id")
  private Long id;

  @Column(name = "roleName")
  private String roleName;

  @ManyToMany(mappedBy = "roles", fetch = FetchType.EAGER)
  private Set<User> users;

    /*-----------------------------------------------------------*/

  public Role() {
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getRoleName() {
    return roleName;
  }

  @SuppressWarnings("unused")
  public void setRoleName(String roleName) {
    this.roleName = roleName;
  }

  @SuppressWarnings("unused")
  public Set<User> getUsers() {
    return users;
  }

  @SuppressWarnings("unused")
  public void setUsers(Set<User> users) {
    this.users = users;
  }

  @Override
  public int hashCode() {
    final int prime = 31;
    int result = 1;
    result = prime * result + (int) (id ^ (id >>> 32));
    return result;
  }

  @Override
  public boolean equals(Object obj) {
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
  public String toString() {
    return "Role [id=" + id + ", roleName=" + roleName + "]";
  }

  @Override
  public int compareTo(Role o) {
    return this.getRoleName().compareTo(o.getRoleName());
  }

}
