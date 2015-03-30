package com.rebok3J.web.forms;

import com.rebok3J.model.impl.Service;
import com.rebok3J.model.impl.Visit;
import com.rebok3J.model.impl.Visitor;

/**
 * @author OrestO
 * @since 3/28/2015
 */
public class AddNewVisitDTO
{
  private Visitor selectedVisitor;
  private Service selectedService;
//  private Date dateOfVisit;

//  public Date getDateOfVisit()
//  {
//    return dateOfVisit;
//  }

//  public void setDateOfVisit(Date dateOfVisit)
//  {
//    this.dateOfVisit = dateOfVisit;
//  }

  public Visitor getSelectedVisitor()
  {
    return selectedVisitor;
  }

  public void setSelectedVisitor(Visitor selectedVisitor)
  {
    this.selectedVisitor = selectedVisitor;
  }

  public Service getSelectedService()
  {
    return selectedService;
  }

  public void setSelectedService(Service selectedService)
  {
    this.selectedService = selectedService;
  }

  public Visit getEntity()
  {
    Visit visit = new Visit();
    visit.setId(null);
    visit.setVisitor(getSelectedVisitor());
    visit.setService(getSelectedService());
//    visit.setDateOfVisit(getDateOfVisit());
    return visit;
  }
}
