package com.rebok3J.model.impl;

import java.util.Date;

import javax.persistence.*;

import com.rebok3J.model.VisitorQueryHolder;

/**
 * Created by OrestO on 3/12/2015.
 */
@Entity
@Table(name = Visitor.VISITOR_TABLE)
@NamedQueries({ @NamedQuery(name = VisitorQueryHolder.FIND_ALL, query = VisitorQueryHolder.FIND_ALL_QUERY) })
public class Visitor implements VisitorQueryHolder, Comparable<Visitor>
{

  public static final String VISITOR_ENTITY = "Visitor";
  public static final String VISITOR_TABLE = "\"VISITOR\"";

  @Id
  @GeneratedValue
  @Column(name = ID_COLUMN)
  private long id;
  public static final String ID_COLUMN = "ID";

  @Column(name = LAST_NAME_COLUMN, nullable = false)
  private String lastName;
  public static final String LAST_NAME_COLUMN = "LAST_NAME";

  @Column(name = FIRST_NAME_COLUMN, nullable = false)
  private String firstName;
  public static final String FIRST_NAME_COLUMN = "FIRST_NAME";

  @Column(name = MIDDLE_NAME_COLUMN, nullable = false)
  private String middleName;
  public static final String MIDDLE_NAME_COLUMN = "MIDDLE_NAME";

  /*TODO: here should be the list*/
  @Column(name = PHONES_COLUMN, nullable = true)
  private String phones;
  public static final String PHONES_COLUMN = "PHONES";

  @Column(name = EMAIL_COLUMN, nullable = true)
  private String email;
  public static final String EMAIL_COLUMN = "EMAIL";

  /*TODO: here should be list of entity Status*/
  @Column(name = STATUS_COLUMN, nullable = true)
  private String status;
  public static final String STATUS_COLUMN = "STATUS";

  @Column(name = NOTE_COLUMN, nullable = true)
  private String note;
  public static final String NOTE_COLUMN = "NOTE";

  @Column(name = SEX_COLUMN, nullable = false)
  private String sex;
  public static final String SEX_COLUMN = "SEX";

  @Temporal(TemporalType.DATE)
  @Column(name = DATE_OF_BIRTH_COLUMN, nullable = false)
  private Date dateOfBirth;
  public static final String DATE_OF_BIRTH_COLUMN = "DATE_OF_BIRTH";

  @Temporal(TemporalType.TIMESTAMP)
  @Column(name = CREATE_DATE_COLUMN, nullable = false)
  private Date createDate;
  public static final String CREATE_DATE_COLUMN = "CREATE_DATE";

  // @OneToMany(mappedBy = "id")
  // private List<Visitor> visits;

  public long getId()
  {
    return id;
  }

  public void setId(long id)
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

  public String getPhones()
  {
    return phones;
  }

  public void setPhones(String phones)
  {
    this.phones = phones;
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

  public String getSex()
  {
    return sex;
  }

  public void setSex(String sex)
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

  @Override
  public boolean equals(Object o)
  {
    if (this == o)
      return true;
    if (o == null || getClass() != o.getClass())
      return false;

    Visitor visitor = (Visitor) o;

    if (!lastName.equals(visitor.lastName))
      return false;
    if (!firstName.equals(visitor.firstName))
      return false;
    if (!middleName.equals(visitor.middleName))
      return false;
    if (phones != null ? !phones.equals(visitor.phones) : visitor.phones != null)
      return false;
    if (email != null ? !email.equals(visitor.email) : visitor.email != null)
      return false;
    if (status != null ? !status.equals(visitor.status) : visitor.status != null)
      return false;
    if (note != null ? !note.equals(visitor.note) : visitor.note != null)
      return false;
    if (!sex.equals(visitor.sex))
      return false;
    return dateOfBirth.equals(visitor.dateOfBirth);

  }

  @Override
  public int hashCode()
  {
    int result = lastName.hashCode();
    result = 31 * result + firstName.hashCode();
    result = 31 * result + middleName.hashCode();
    result = 31 * result + (phones != null ? phones.hashCode() : 0);
    result = 31 * result + (email != null ? email.hashCode() : 0);
    result = 31 * result + (status != null ? status.hashCode() : 0);
    result = 31 * result + (note != null ? note.hashCode() : 0);
    result = 31 * result + sex.hashCode();
    result = 31 * result + dateOfBirth.hashCode();
    return result;
  }

  @Override
  public String toString()
  {
    return "Visitor{" + "id=" + id + ", lastName='" + lastName + "', firstName='" + firstName + "', middleName='" + middleName + "', phones='" + phones + "', email='" + email + "', status='" + status
        + "', note='" + note + "', sex='" + sex + "', dateOfBirth=" + dateOfBirth + ", createDate=" + createDate + '}';
  }

  @Override
  public String getFindAllQueryName()
  {
    return FIND_ALL;
  }

  @Override
  public int compareTo(Visitor o)
  {
    return this.getLastName().compareToIgnoreCase(o.getLastName()) 
        - this.getFirstName().compareToIgnoreCase(o.getFirstName()) 
        - this.getMiddleName().compareToIgnoreCase(o.getMiddleName())
        - this.getDateOfBirth().compareTo(o.getDateOfBirth());
  }
}
