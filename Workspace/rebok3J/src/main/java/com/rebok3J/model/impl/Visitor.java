package com.rebok3J.model.impl;

import java.util.Date;

import javax.annotation.Nonnull;
import javax.persistence.*;

import com.rebok3J.model.ModelObjectImpl;
import com.rebok3J.model.Sex;
import com.rebok3J.model.VisitorQueryHolder;

/**
 *
 *
 * @author OrestO
 * @since 3/12/2015
 */
@Entity
@Table(name = Visitor.VISITOR_TABLE)

@NamedNativeQueries({
    @NamedNativeQuery(name = VisitorQueryHolder.GET_ALL_VISITORS_FOR_SELECT, query = VisitorQueryHolder.GET_ALL_VISITORS_FOR_SELECT_QUERY)
})
@NamedQueries({ @NamedQuery(name = VisitorQueryHolder.FIND_ALL, query = VisitorQueryHolder.FIND_ALL_QUERY) })
public class Visitor extends ModelObjectImpl<Visitor> implements VisitorQueryHolder
{

  private static final long serialVersionUID = 1L;

  public static final String VISITOR_ENTITY = "Visitor";
  public static final String VISITOR_TABLE = "\"visitor\"";

  @Id
  @SequenceGenerator(name = ID_SEQ, sequenceName = ID_SEQ, allocationSize = 1)
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = ID_SEQ)
  @Column(name = ID_COLUMN)
  private Long id;
  public static final String ID_COLUMN = "id";
  public static final String ID_SEQ = "visitor_id_seq";

  @Column(name = LAST_NAME_COLUMN, nullable = false)
  private String lastName;
  public static final String LAST_NAME_COLUMN = "last_name";

  @Column(name = FIRST_NAME_COLUMN, nullable = false)
  private String firstName;
  public static final String FIRST_NAME_COLUMN = "first_name";

  @Column(name = MIDDLE_NAME_COLUMN, nullable = false)
  private String middleName;
  public static final String MIDDLE_NAME_COLUMN = "middle_name";

  /* TODO: here should be the list */
  @Column(name = PHONES_COLUMN, nullable = true)
  private String phone;
  public static final String PHONES_COLUMN = "phone";

  @Column(name = EMAIL_COLUMN, nullable = true)
  private String email;
  public static final String EMAIL_COLUMN = "email";

  /* TODO: here should be list of entity Status */
  @Column(name = STATUS_COLUMN, nullable = true)
  private String status;
  public static final String STATUS_COLUMN = "status";

  @Column(name = NOTE_COLUMN, nullable = true)
  private String note;
  public static final String NOTE_COLUMN = "note";

  @Column(name = SEX_COLUMN, nullable = false)
  private Sex sex;
  public static final String SEX_COLUMN = "sex";

  @Temporal(TemporalType.DATE)
  @Column(name = DATE_OF_BIRTH_COLUMN, nullable = false)
  private Date dateOfBirth;
  public static final String DATE_OF_BIRTH_COLUMN = "date_of_birth";

  @Temporal(TemporalType.TIMESTAMP)
  @Column(name = CREATE_DATE_COLUMN, nullable = false)
  private Date createDate;
  public static final String CREATE_DATE_COLUMN = "create_date";

  @Temporal(TemporalType.TIMESTAMP)
  @Column(name = LAST_UPDATE_TIMESTAMP_COLUMN, nullable = false)
  private Date lastUpdated;
  public static final String LAST_UPDATE_TIMESTAMP_COLUMN = "last_update_timestamp";

  // @OneToMany(mappedBy = "id")
  // private List<Visitor> visits;

  public Long getId()
  {
    return id;
  }

  public void setId(Long id)
  {
    this.id = id;
  }

  public String getLastName()
  {
    return lastName;
  }

  public void setLastName(String lastName)
  {
    this.lastName = lastName;
  }

  public String getFirstName()
  {
    return firstName;
  }

  public void setFirstName(String firstName)
  {
    this.firstName = firstName;
  }

  public String getMiddleName()
  {
    return middleName;
  }

  public void setMiddleName(String middleName)
  {
    this.middleName = middleName;
  }

  public String getPhone()
  {
    return phone;
  }

  public void setPhone(String phone)
  {
    this.phone = phone;
  }

  public String getEmail()
  {
    return email;
  }

  public void setEmail(String email)
  {
    this.email = email;
  }

  public String getStatus()
  {
    return status;
  }

  public void setStatus(String status)
  {
    this.status = status;
  }

  public String getNote()
  {
    return note;
  }

  public void setNote(String note)
  {
    this.note = note;
  }

  public Sex getSex()
  {
    return sex;
  }

  public void setSex(Sex sex)
  {
    this.sex = sex;
  }

  public Date getDateOfBirth()
  {
    return dateOfBirth;
  }

  public void setDateOfBirth(Date dateOfBirth)
  {
    this.dateOfBirth = dateOfBirth;
  }

  public Date getCreateDate()
  {
    return createDate;
  }

  public void setCreateDate(Date createDate)
  {
    this.createDate = createDate;
  }

  public Date getLastUpdated()
  {
    return lastUpdated;
  }

  public void setLastUpdated(Date lastUpdated)
  {
    this.lastUpdated = lastUpdated;
  }

  @Override
  public int hashCode()
  {
    return super.hashCode(id);
  }

  @Override
  public boolean equals(Object obj)
  {
    return obj instanceof Visitor && super.equals(this, (Visitor) obj);
  }

  @Override
  public String toString()
  {
    return "Visitor{" + "id=" + id + ", lastName='" + lastName + "', firstName='" + firstName + "', middleName='" + middleName + "', phone='" + phone + "', email='" + email + "', status='" + status
        + "', note='" + note + "', sex='" + sex + "', dateOfBirth=" + dateOfBirth + ", createDate=" + createDate + '}';
  }

  @Override
  public String getFindAllQueryName()
  {
    return FIND_ALL;
  }

  @Override
  public String getAllServicesForSelect()
  {
    return GET_ALL_VISITORS_FOR_SELECT;
  }

  @Override
  public int compareTo(@Nonnull Visitor obj)
  {
    return this.getLastName().compareToIgnoreCase(obj.getLastName()) - this.getFirstName().compareToIgnoreCase(obj.getFirstName()) - this.getMiddleName().compareToIgnoreCase(obj.getMiddleName())
        - this.getDateOfBirth().compareTo(obj.getDateOfBirth());
  }

  public String getFullName()
  {
    return lastName + " " + firstName + " " + middleName;
  }

  @PrePersist
  public void createdTimestamp()
  {
    createDate = new Date();
    lastUpdated = new Date();
  }

  @PreUpdate
  public void lastUpdatedTimestamp()
  {
    lastUpdated = new Date();
  }
}
