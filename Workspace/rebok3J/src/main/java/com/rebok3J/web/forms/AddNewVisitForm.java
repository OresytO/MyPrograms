package com.rebok3J.web.forms;

import java.util.List;

import com.rebok3J.web.forms.elements.SelectDTO;

/**
 * @author OrestO
 * @since 3/28/2015
 */
public class AddNewVisitForm
{
  private List<SelectDTO> allVisitors;
  private List<SelectDTO> allServicesForSelect;

  public List<SelectDTO> getAllServicesForSelect()
  {
    return allServicesForSelect;
  }

  public void setAllServicesForSelect(List<SelectDTO> allServicesForSelect)
  {
    this.allServicesForSelect = allServicesForSelect;
  }

  public List<SelectDTO> getAllVisitors()
  {
    return allVisitors;
  }

  public void setAllVisitors(List<SelectDTO> allVisitors)
  {
    this.allVisitors = allVisitors;
  }

}
