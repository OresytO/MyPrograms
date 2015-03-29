package com.rebok3J.web.forms;

/**
 * @author OrestO
 * @since 3/28/2015
 */
public class AddNewVisitDTO
{
  private String visitorLastName;
  private String visitorId;
  private String visitorFirstName;
  private String visitorMiddleName;
  private String visitorSex;
  private String serviceName;

  public String getVisitorLastName()
  {
    return visitorLastName;
  }

  public void setVisitorLastName(String visitorLastName)
  {
    this.visitorLastName = visitorLastName;
  }

  public String getVisitorId()
  {
    return visitorId;
  }

  public void setVisitorId(String visitorId)
  {
    this.visitorId = visitorId;
  }

  public String getVisitorFirstName()
  {
    return visitorFirstName;
  }

  public void setVisitorFirstName(String visitorFirstName)
  {
    this.visitorFirstName = visitorFirstName;
  }

  public String getVisitorMiddleName()
  {
    return visitorMiddleName;
  }

  public void setVisitorMiddleName(String visitorMiddleName)
  {
    this.visitorMiddleName = visitorMiddleName;
  }

  public String getVisitorSex()
  {
    return visitorSex;
  }

  public void setVisitorSex(String visitorSex)
  {
    this.visitorSex = visitorSex;
  }

  public String getServiceName()
  {
    return serviceName;
  }

  public void setServiceName(String serviceName)
  {
    this.serviceName = serviceName;
  }
}
