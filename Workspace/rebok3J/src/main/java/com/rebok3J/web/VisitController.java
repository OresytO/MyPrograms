package com.rebok3J.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.rebok3J.model.impl.Visit;
import com.rebok3J.services.ServiceService;
import com.rebok3J.services.VisitService;
import com.rebok3J.services.VisitorService;
import com.rebok3J.web.forms.AddNewVisitDTO;
import com.rebok3J.web.forms.AddNewVisitForm;

/**
 *
 *
 * @author OrestO
 * @since 3/11/2015
 */
@Controller
@RequestMapping(value = "/visit**")
public class VisitController
{

  @Autowired
  private VisitService visitService;

  @Autowired
  private ServiceService serviceService;

  @Autowired
  private VisitorService visitorService;

  public static final String ADD_URL = "/add";

  @RequestMapping(value = ADD_URL, method = RequestMethod.GET)
  public ModelAndView addNewVisitShow(@ModelAttribute AddNewVisitForm addNewVisitForm, @ModelAttribute AddNewVisitDTO addNewVisitDTO)
  {
    addNewVisitForm.setAllServicesForSelect(serviceService.getAllServicesForSelect());
    addNewVisitForm.setAllVisitors(visitorService.getAllVisitorsForSelect());

    ModelAndView mv = MvHelper.get("visit/addVisit");
    mv.addObject("addNewVisitForm", addNewVisitForm);
    return mv;
  }

  @RequestMapping(value = ADD_URL, method = RequestMethod.POST)
  public ModelAndView addNewVisit(@ModelAttribute AddNewVisitDTO addNewVisitDTO)
  {
    visitService.save(addNewVisitDTO.getEntity(serviceService, visitorService));
    return MvHelper.get("visit/viewVisit");
  }

  public static final String SEARCH_URL = "/search";

  @RequestMapping(value = SEARCH_URL, method = RequestMethod.GET)
  public ModelAndView searchVisit()
  {
    return MvHelper.get("visit/searchVisit");
  }

  public static final String VIEW_URL = "/view";

  @RequestMapping(value = VIEW_URL, method = RequestMethod.GET)
  public ModelAndView viewVisit()
  {
    return MvHelper.get("visit/viewVisit");
  }

  @ModelAttribute("allVisits")
  public List<Visit> allVisits() throws IllegalAccessException, InstantiationException
  {
    return visitService.loadAll();
  }
}
