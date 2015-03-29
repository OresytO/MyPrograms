package com.rebok3J.web.forms;

import com.rebok3J.model.impl.Salon;

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

  public Salon getEntity()
  {
    Salon salon = new Salon();
    salon.setId(null);
    salon.setName(getSalonName());
    salon.setAddress(getSalonAddress());
    return salon;
  }
}
