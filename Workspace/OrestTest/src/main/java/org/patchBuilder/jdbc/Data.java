package org.patchBuilder.jdbc;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "Tag")
@NamedQueries({
// -----
@NamedQuery(name = "First_Query", query = "SELECT d FROM Data d")
// -----
})
public class Data {

    @Id
    @Column(name = "ID")
    private String field1;

    @Column(name = "DimensionExternalID")
    private String field3;

    @Column(name = "Label")
    private String field4;

    @Column(name = "CreateTimestamp")
    private String field5;

    @Column(name = "LastUpdateTimestamp")
    private String field6;

    public Data() {

    }

    // -----

    public String getField1() {
        return field1;
    }

    public void setField1(String field1) {
        this.field1 = field1;
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

    public String getField5() {
        return field5;
    }

    public void setField5(String field5) {
        this.field5 = field5;
    }

    public String getField6() {
        return field6;
    }

    public void setField6(String field6) {
        this.field6 = field6;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((field1 == null) ? 0 : field1.hashCode());
        result = prime * result + ((field3 == null) ? 0 : field3.hashCode());
        result = prime * result + ((field4 == null) ? 0 : field4.hashCode());
        result = prime * result + ((field5 == null) ? 0 : field5.hashCode());
        result = prime * result + ((field6 == null) ? 0 : field6.hashCode());
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
        if (field5 == null) {
            if (other.field5 != null)
                return false;
        } else if (!field5.equals(other.field5))
            return false;
        if (field6 == null) {
            if (other.field6 != null)
                return false;
        } else if (!field6.equals(other.field6))
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "Data [field1=" + field1 + ", field3=" + field3 + ", field4=" + field4 + ", field5=" + field5 + ", field6=" + field6 + "]";
    }

}
