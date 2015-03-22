package com.rebok3J.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by OrestO on 3/11/2015.
 */
@Controller
@RequestMapping(value = "/visit**")
public class VisitController
{

  public static final String ADD_URL = "/add";

  @RequestMapping(value = ADD_URL, method = RequestMethod.GET)
  public String addVisit(Model model) throws InstantiationException, IllegalAccessException
  {
    return "visit/addVisit";
  }

  // @Secured({Role.ROLE_ADMIN})
  // @PreAuthorize("hasRole('ROLE_ADMIN')")
  public static final String SEARCH_URL = "/search";

  @RequestMapping(value = SEARCH_URL, method = RequestMethod.GET)
  public String searchVisit(Model model) throws InstantiationException, IllegalAccessException
  {
    return "visit/searchVisit";
  }

  // @Secured({Role.ROLE_ADMIN})
  // @PreAuthorize("hasRole('ROLE_ADMIN')")
  public static final String VIEW_URL = "/view";

  @RequestMapping(value = VIEW_URL, method = RequestMethod.GET)
  public String viewVisit(Model model) throws InstantiationException, IllegalAccessException
  {
    return "visit/viewVisit";
  }
}
