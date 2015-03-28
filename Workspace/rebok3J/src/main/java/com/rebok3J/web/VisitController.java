package com.rebok3J.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

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

  public static final String ADD_URL = "/add";

  @RequestMapping(value = ADD_URL, method = RequestMethod.GET)
  public ModelAndView addVisit()
  {
    return MvHelper.get("visit/addVisit");
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
}
