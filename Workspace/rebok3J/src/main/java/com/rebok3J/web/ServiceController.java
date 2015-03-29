package com.rebok3J.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.rebok3J.model.impl.Service;
import com.rebok3J.services.ServiceService;

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

  @Autowired
  private ServiceService serviceService;

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

  @ModelAttribute("allServices")
  public List<Service> allServices() throws IllegalAccessException, InstantiationException
  {
    return serviceService.loadAll();
  }
}
