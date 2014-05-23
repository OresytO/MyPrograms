package tc.lv.domain;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "roles")
@NamedQuery(name = Role.FIND_BY_NAME, query = Role.FIND_BY_NAME_QUERY)
public class Role {

    public static final String FIND_BY_NAME = "Role.findByName";
    public static final String FIND_BY_NAME_QUERY = "SELECT r FROM Role r WHERE r.role = ?1";

    @Id
    @Column(name = "role_id", nullable = false)
    private int id;

    @Column(name = "role", nullable = false)
    private String role;

    @ManyToMany(mappedBy = "roleSet", fetch = FetchType.EAGER)
    private Set<User> userSet = new HashSet<User>();

    public Role() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Set<User> getUserSet() {
        return userSet;
    }

    public void setUserSet(Set<User> userSet) {
        this.userSet = userSet;
    }

    public static String getFindByName() {
        return FIND_BY_NAME;
    }

    public static String getFindByNameQuery() {
        return FIND_BY_NAME_QUERY;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + id;
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
        if (id != other.id)
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "Role [id=" + id + ", role=" + role + "]";
    }

}
