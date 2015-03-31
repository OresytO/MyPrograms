package com.rebok3J.web.forms;

import java.util.ArrayList;
import java.util.List;

import com.rebok3J.model.Sex;
import com.rebok3J.web.forms.elements.SelectDTO;

/**
 * @author OrestO
 * @since 3/28/2015
 */
public class AddNewVisitorForm
{
  private List<SelectDTO> sexes;

  public List<SelectDTO> getSexes()
  {
    List<SelectDTO> sexes = new ArrayList<>();

    for (Sex sex : Sex.values())
    {
      sexes.add(new SelectDTO((long) sex.ordinal(), sex.getMessageKey()));
    }
    return sexes;
  }
}
