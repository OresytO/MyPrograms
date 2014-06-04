package org.rebok2j.domain;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "Users")
@NamedQueries({ @NamedQuery(name = "User.findByNickname", query = "select u from User u where u.userNickname = :nickname"),
        @NamedQuery(name = "User.findAllUsers", query = "select u from User u") })
public class User implements Serializable, Comparable<User> {

    private static final long serialVersionUID = -7588331808777137405L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long Id;

    @Column(name = "userNickname")
    private String userNickname;

    @Column(name = "password")
    private String password;

    @Column(name = "userName")
    private String userName;

    @Column(name = "enabled")
    private Boolean enabled;

    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinTable(name = "UsersRoles", joinColumns = { @JoinColumn(name = "user_id", updatable = true, nullable = true) }, inverseJoinColumns = { @JoinColumn(name = "role_id", updatable = true, nullable = true) })
    private Set<Role> roles;

    /*-----------------------------------------------------------*/

    public User() {
    }

    public Long getId() {
        return Id;
    }

    public void setId(Long id) {
        Id = id;
    }

    public String getUserNickname() {
        return userNickname;
    }

    public void setUserNickname(String userNickname) {
        this.userNickname = userNickname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    // @Override
    // public int hashCode() {
    // return userNickname.hashCode();
    // }

    @Override
    public boolean equals(Object obj) {
        return userNickname.equalsIgnoreCase((String) obj);
    }

    @Override
    public String toString() {
        return "User [Id=" + Id + ", userName=" + userName + "]";
    }

    @Override
    public int compareTo(User o) {
        return this.getUserNickname().compareTo(o.getUserNickname());
    }

}
