package com.rebok3J.web.forms;

import java.util.Date;

import com.rebok3J.model.impl.Visit;
import com.rebok3J.services.ServiceService;
import com.rebok3J.services.VisitorService;

/**
 * @author OrestO
 * @since 3/28/2015
 */
public class AddNewVisitDTO
{
  private String selectedVisitor;
  private String selectedService;
  private Date dateOfVisit;

  public Date getDateOfVisit()
  {
    return dateOfVisit;
  }

  public void setDateOfVisit(Date dateOfVisit)
  {
    this.dateOfVisit = dateOfVisit;
  }

  public String getSelectedVisitor()
  {
    return selectedVisitor;
  }

  public void setSelectedVisitor(String selectedVisitor)
  {
    this.selectedVisitor = selectedVisitor;
  }

  public String getSelectedService()
  {
    return selectedService;
  }

  public void setSelectedService(String selectedService)
  {
    this.selectedService = selectedService;
  }

  public Visit getEntity(ServiceService serviceService, VisitorService visitorService)
  {
    Visit visit = new Visit();
    visit.setId(null);
    visit.setVisitor(visitorService.findById(Long.parseLong(getSelectedVisitor())));
    visit.setService(serviceService.findById(Long.parseLong(getSelectedService())));
    visit.setDateOfVisit(getDateOfVisit());
    return visit;
  }
}
