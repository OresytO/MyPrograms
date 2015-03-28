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
@RequestMapping(value = "/service**")
public class ServiceController
{

  public static final String ADD_URL = "/add";

  @RequestMapping(value = ADD_URL, method = RequestMethod.GET)
  public ModelAndView addService()
  {
    return MvHelper.get("service/addService");
  }

  public static final String SEARCH_URL = "/search";

  @RequestMapping(value = SEARCH_URL, method = RequestMethod.GET)
  public ModelAndView searchService()
  {
    return MvHelper.get("service/searchService");
  }

  public static final String VIEW_URL = "/view";

  @RequestMapping(value = VIEW_URL, method = RequestMethod.GET)
  public ModelAndView viewService()
  {
    return MvHelper.get("service/viewService");
  }
}
