package com.rebok3J.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.rebok3J.model.impl.Visitor;
import com.rebok3J.services.VisitorService;
import com.rebok3J.web.forms.AddNewVisitorDTO;
import com.rebok3J.web.forms.AddNewVisitorForm;

/**
 * @author OrestO
 * @since 3/11/2015
 */
@Controller
@RequestMapping(value = "/visitor**")
public class VisitorController
{
  @Autowired
  private VisitorService visitorService;

  public static final String ADD_URL = "/add";

  @RequestMapping(value = ADD_URL, method = RequestMethod.GET)
  public ModelAndView addNewVisitorShow(@ModelAttribute AddNewVisitorDTO addNewVisitorDTO, @ModelAttribute AddNewVisitorForm addNewVisitorForm)
  {
    return MvHelper.get("visitor/addVisitor");
  }

  @RequestMapping(value = ADD_URL, method = RequestMethod.POST)
  public ModelAndView addNewVisitor(@ModelAttribute AddNewVisitorDTO addNewVisitorDTO)
  {
    visitorService.save(addNewVisitorDTO.getEntity());
    return MvHelper.get("visitor/searchVisitor");
  }

  public static final String SEARCH_URL = "/search";

  @RequestMapping(value = SEARCH_URL, method = RequestMethod.GET)
  public ModelAndView searchVisitorShow() throws InstantiationException, IllegalAccessException
  {
    return MvHelper.get("visitor/searchVisitor").addObject("allVisitors", allVisitors());
  }

  public static final String VIEW_URL = "/view/{id}";

  @RequestMapping(value = VIEW_URL, method = RequestMethod.GET)
  public ModelAndView viewVisitor(@PathVariable Long id)
  {
    return MvHelper.get("visitor/viewVisitor").addObject(visitorService.findById(id));
  }

  @ModelAttribute("allVisitors")
  public List<Visitor> allVisitors() throws IllegalAccessException, InstantiationException
  {
    return visitorService.loadAll();
  }

}
