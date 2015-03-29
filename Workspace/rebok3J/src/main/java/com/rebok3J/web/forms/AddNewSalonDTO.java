package com.rebok3J.web.forms;

/**
 * @author OrestO
 * @since 3/28/2015
 */
public class AddNewSalonDTO
{
  private String salonName;
  private String salonAddress;

  public String getSalonName()
  {
    return salonName;
  }

  public void setSalonName(String salonName)
  {
    this.salonName = salonName;
  }

  public String getSalonAddress()
  {
    return salonAddress;
  }

  public void setSalonAddress(String salonAddress)
  {
    this.salonAddress = salonAddress;
  }
}
