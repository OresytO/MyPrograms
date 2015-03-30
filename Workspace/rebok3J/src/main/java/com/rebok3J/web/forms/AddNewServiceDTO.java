package com.rebok3J.web.forms;

import com.rebok3J.model.impl.Service;

/**
 * @author OrestO
 * @since 3/28/2015
 */
public class AddNewServiceDTO
{
  private String serviceName;
  private String serviceType;

  public String getServiceName()
  {
    return serviceName;
  }

  public void setServiceName(String serviceName)
  {
    this.serviceName = serviceName;
  }

  public String getServiceType()
  {
    return serviceType;
  }

  public void setServiceType(String serviceType)
  {
    this.serviceType = serviceType;
  }

  public Service getEntity()
  {
    Service service = new Service();
    service.setId(null);
    service.setName(getServiceName());
    service.setType(getServiceType());
    return service;
  }
}
