package org.rebok2j.domain;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

import static org.rebok2j.utils.DomainConstants.USER;

@Entity
@Table(name = "Users")
@NamedQueries({@NamedQuery(name = USER.FIND_BY_NICKNAME, query = USER.FIND_BY_NICKNAME_Q),
        @NamedQuery(name = USER.FIND_ALL, query = USER.FIND_ALL_Q)})
public class User implements Domain, Serializable, Comparable<User> {

    private static final long serialVersionUID = -7588331808777137405L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "userNickname")
    private String userNickname;

    @Column(name = "password")
    private String password;

    @Column(name = "userName")
    private String userName;

    @Column(name = "enabled")
    private Boolean enabled;

    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinTable(name = "UsersRoles", joinColumns = {@JoinColumn(name = "user_id", updatable = true, nullable = true)}, inverseJoinColumns = {@JoinColumn(name = "role_id", updatable = true, nullable = true)})
    private Set<Role> roles;

    /*-----------------------------------------------------------*/

    public User() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUserNickname() {
        return userNickname;
    }

    @SuppressWarnings("unused")
    public void setUserNickname(String userNickname) {
        this.userNickname = userNickname;
    }

    public String getPassword() {
        return password;
    }

    @SuppressWarnings("unused")
    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserName() {
        return userName;
    }

    @SuppressWarnings("unused")
    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    @SuppressWarnings("unused")
    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    @SuppressWarnings("unused")
    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    // @Override
    // public int hashCode() {
    // return userNickname.hashCode();
    // }

    @Override
    public boolean equals(Object obj) {
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
    public String toString() {
        return "User [id=" + id + ", userName=" + userName + "]";
    }

    @Override
    public int compareTo(User o) {
        return this.getUserNickname().compareTo(o.getUserNickname());
    }

}
