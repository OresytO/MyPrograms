package com.rebok3J.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by OrestO on 3/11/2015.
 */
@Controller
@RequestMapping(value = "/service**")
public class ServiceController
{

  public static final String ADD_URL = "/add";

  @RequestMapping(value = ADD_URL, method = RequestMethod.GET)
  public String addService(Model model) throws InstantiationException, IllegalAccessException
  {
    return "service/addService";
  }

  // @Secured({Role.ROLE_ADMIN})
  // @PreAuthorize("hasRole('ROLE_ADMIN')")
  public static final String SEARCH_URL = "/search";

  @RequestMapping(value = SEARCH_URL, method = RequestMethod.GET)
  public String searchService(Model model) throws InstantiationException, IllegalAccessException
  {
    return "service/searchService";
  }

  // @Secured({Role.ROLE_ADMIN})
  // @PreAuthorize("hasRole('ROLE_ADMIN')")
  public static final String VIEW_URL = "/view";

  @RequestMapping(value = VIEW_URL, method = RequestMethod.GET)
  public String viewService(Model model) throws InstantiationException, IllegalAccessException
  {
    return "service/viewService";
  }
}
