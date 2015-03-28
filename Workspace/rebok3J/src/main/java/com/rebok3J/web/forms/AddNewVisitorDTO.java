package com.rebok3J.web.forms;

import java.util.List;

import org.joda.time.DateTime;

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
  private DateTime dateOfBirth;
  private List<String> phoneNumbers;
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

  public DateTime getDateOfBirth()
  {
    return dateOfBirth;
  }

  public void setDateOfBirth(DateTime dateOfBirth)
  {
    this.dateOfBirth = dateOfBirth;
  }

  public List<String> getPhoneNumbers()
  {
    return phoneNumbers;
  }

  public void setPhoneNumbers(List<String> phoneNumbers)
  {
    this.phoneNumbers = phoneNumbers;
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
}
