package com.rebok3J.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by OrestO on 3/11/2015.
 */
@Controller
@RequestMapping(value = "/visitor**")
public class VisitorController
{

  public static final String ADD_URL = "/add";

  @RequestMapping(value = ADD_URL, method = RequestMethod.GET)
  public String addVisitor(Model model) throws InstantiationException, IllegalAccessException
  {
    return "visitor/addVisitor";
  }

  // @Secured({Role.ROLE_ADMIN})
  // @PreAuthorize("hasRole('ROLE_ADMIN')")
  public static final String SEARCH_URL = "/search";

  @RequestMapping(value = SEARCH_URL, method = RequestMethod.GET)
  public String searchVisitor(Model model) throws InstantiationException, IllegalAccessException
  {
    return "visitor/searchVisitor";
  }

  // @Secured({Role.ROLE_ADMIN})
  // @PreAuthorize("hasRole('ROLE_ADMIN')")
  public static final String VIEW_URL = "/view";

  @RequestMapping(value = VIEW_URL, method = RequestMethod.GET)
  public String viewVisitor(Model model) throws InstantiationException, IllegalAccessException
  {
    return "visitor/viewVisitor";
  }
}
