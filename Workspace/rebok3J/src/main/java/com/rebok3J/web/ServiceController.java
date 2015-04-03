package com.rebok3J.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.rebok3J.model.impl.Service;
import com.rebok3J.services.ServiceService;
import com.rebok3J.web.forms.AddNewServiceDTO;

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
  public ModelAndView addNewServiceShow(@ModelAttribute AddNewServiceDTO addNewServiceDTO)
  {
    return MvHelper.get("service/addService");
  }

  @RequestMapping(value = ADD_URL, method = RequestMethod.POST)
  public ModelAndView addNewService(@ModelAttribute AddNewServiceDTO addNewServiceDTO)
  {
    serviceService.save(addNewServiceDTO.getEntity());
    return MvHelper.get("service/searchService");
  }

  public static final String SEARCH_URL = "/search";

  @RequestMapping(value = SEARCH_URL, method = RequestMethod.GET)
  public ModelAndView searchService() throws InstantiationException, IllegalAccessException
  {
    return MvHelper.get("service/searchService").addObject("allServices", allServices());
  }

  public static final String VIEW_URL = "/view/{id}";

  @RequestMapping(value = VIEW_URL, method = RequestMethod.GET)
  public ModelAndView viewService(@PathVariable Long id)
  {
    return MvHelper.get("service/viewService").addObject(serviceService.findById(id));
  }

  @ModelAttribute("allServices")
  public List<Service> allServices() throws IllegalAccessException, InstantiationException
  {
    return serviceService.loadAll();
  }
}
