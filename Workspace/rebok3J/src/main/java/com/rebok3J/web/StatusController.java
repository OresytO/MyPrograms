package com.rebok3J.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.rebok3J.model.impl.Status;
import com.rebok3J.services.StatusService;
import com.rebok3J.web.forms.AddNewStatusDTO;

/**
 *
 *
 * @author OrestO
 * @since 3/11/2015
 */
@Controller
@RequestMapping(value = "/status**")
public class StatusController
{

  @Autowired
  private StatusService statusService;

  public static final String ADD_URL = "/add";

  @RequestMapping(value = ADD_URL, method = RequestMethod.GET)
  public ModelAndView addNewStatusShow(@ModelAttribute AddNewStatusDTO addNewStatusDTO)
  {
    return MvHelper.get("status/addStatus");
  }

  @RequestMapping(value = ADD_URL, method = RequestMethod.POST)
  public ModelAndView addNewStatus(@ModelAttribute AddNewStatusDTO addNewStatusDTO) throws InstantiationException, IllegalAccessException
  {
    statusService.save(addNewStatusDTO.getEntity());
    return MvHelper.get("status/searchStatus").addObject("allStatuses", allStatuses());
  }

  public static final String SEARCH_URL = "/search";

  @RequestMapping(value = SEARCH_URL, method = RequestMethod.GET)
  public ModelAndView searchStatus() throws InstantiationException, IllegalAccessException
  {
    return MvHelper.get("status/searchStatus");
  }

  public static final String VIEW_URL = "/view/{id}";

  @RequestMapping(value = VIEW_URL, method = RequestMethod.GET)
  public ModelAndView viewStatus(@PathVariable Long id)
  {
    return MvHelper.get("status/viewStatus").addObject(statusService.findById(id));
  }

  @ModelAttribute("allStatuses")
  public List<Status> allStatuses() throws IllegalAccessException, InstantiationException
  {
    return statusService.loadAll();
  }
}
