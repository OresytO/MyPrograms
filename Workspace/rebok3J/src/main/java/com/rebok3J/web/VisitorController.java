package com.rebok3J.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.rebok3J.web.forms.AddNewVisitorDTO;

/**
 *
 *
 * @author OrestO
 * @since 3/11/2015
 */
@Controller
@RequestMapping(value = "/visitor**")
public class VisitorController
{

  public static final String ADD_URL = "/add";

  @RequestMapping(value = ADD_URL, method = RequestMethod.GET)
  public ModelAndView addNewVisitorShow()
  {
    return MvHelper.get("visitor/addVisitor");
  }

  @RequestMapping(value = ADD_URL, method = RequestMethod.POST)
  public ModelAndView addNewVisitor(@ModelAttribute AddNewVisitorDTO addNewVisitorDTO)
  {
    return MvHelper.get("visitor/viewVisitor");
//    return viewVisitor();
  }

  public static final String SEARCH_URL = "/search";

  @RequestMapping(value = SEARCH_URL, method = RequestMethod.GET)
  public ModelAndView searchVisitor()
  {
    return MvHelper.get("visitor/searchVisitor");
  }

  public static final String VIEW_URL = "/view";

  @RequestMapping(value = VIEW_URL, method = RequestMethod.GET)
  public ModelAndView viewVisitor()
  {
    return MvHelper.get("visitor/viewVisitor");
  }
}
