package com.rebok3J.web.forms;

import java.util.Date;

import com.rebok3J.model.Sex;
import com.rebok3J.model.impl.Visitor;

/**
 * @author OrestO
 * @since 3/28/2015
 */
public class AddNewVisitorDTO
{
  private String lastName;
  private String firstName;
  private String middleName;
  private String sex;
  private Date dateOfBirth;
  private String phoneNumber;
  private String email;
  private String status;
  private String Note;

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

  public String getPhoneNumber()
  {
    return phoneNumber;
  }

  public void setPhoneNumber(String phoneNumber)
  {
    this.phoneNumber = phoneNumber;
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
    return Note;
  }

  public void setNote(String note)
  {
    Note = note;
  }

  public Visitor getEntity()
  {
    Visitor visitor = new Visitor();
    visitor.setId(null);
    visitor.setLastName(getLastName());
    visitor.setFirstName(getFirstName());
    visitor.setMiddleName(getMiddleName());
    visitor.setSex(Sex.getValueOf(getSex()));
    visitor.setDateOfBirth(getDateOfBirth());
    visitor.setPhone(getPhoneNumber());
    visitor.setEmail(getEmail());
    visitor.setStatus(getStatus());
    visitor.setNote(getNote());
    return visitor;
  }
}
