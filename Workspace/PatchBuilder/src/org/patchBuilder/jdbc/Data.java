package org.patchBuilder.jdbc;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "ReviewTag")
@NamedQueries({
// -----
@NamedQuery(name = "First_Query", query = "SELECT From Data")
// -----
})
public class Data {

    @Id
    @Column(name = "ReviewVersionID")
    private String field1;

    @Column(name = "TagID")
    private String field2;

    @Column(name = "OrderIdx")
    private String field3;

    @Column(name = "LastUpdateTimestamp")
    private String field4;

    public Data() {

    }

    public String getField1() {
        return field1;
    }

    public void setField1(String field1) {
        this.field1 = field1;
    }

    public String getField2() {
        return field2;
    }

    public void setField2(String field2) {
        this.field2 = field2;
    }

    public String getField3() {
        return field3;
    }

    public void setField3(String field3) {
        this.field3 = field3;
    }

    public String getField4() {
        return field4;
    }

    public void setField4(String field4) {
        this.field4 = field4;
    }

    @Override
    public String toString() {
        return "Data [field1=" + field1 + ", field2=" + field2 + ", field3=" + field3 + ", field4=" + field4 + "]";
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((field1 == null) ? 0 : field1.hashCode());
        result = prime * result + ((field2 == null) ? 0 : field2.hashCode());
        result = prime * result + ((field3 == null) ? 0 : field3.hashCode());
        result = prime * result + ((field4 == null) ? 0 : field4.hashCode());
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
        Data other = (Data) obj;
        if (field1 == null) {
            if (other.field1 != null)
                return false;
        } else if (!field1.equals(other.field1))
            return false;
        if (field2 == null) {
            if (other.field2 != null)
                return false;
        } else if (!field2.equals(other.field2))
            return false;
        if (field3 == null) {
            if (other.field3 != null)
                return false;
        } else if (!field3.equals(other.field3))
            return false;
        if (field4 == null) {
            if (other.field4 != null)
                return false;
        } else if (!field4.equals(other.field4))
            return false;
        return true;
    }

}
