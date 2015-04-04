package com.rebok3J.web.forms;

import com.rebok3J.model.impl.Status;

/**
 * @author OrestO
 * @since 3/28/2015
 */
public class AddNewStatusDTO
{
  private String statusName;

  public String getStatusName()
  {
    return statusName;
  }

  public void setStatusName(String statusName)
  {
    this.statusName = statusName;
  }

  public Status getEntity()
  {
    Status status = new Status();
    status.setId(null);
    status.setName(getStatusName());
    return status;
  }
}
