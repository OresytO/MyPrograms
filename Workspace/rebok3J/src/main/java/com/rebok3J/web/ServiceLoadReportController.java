package com.rebok3J.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.rebok3J.model.impl.ServiceLoadReport;
import com.rebok3J.services.ServiceLoadReportService;

/**
 *
 *
 * @author OrestO
 * @since 3/11/2015
 */
@Controller
@RequestMapping(value = "/reports/serviceLoad**")
public class ServiceLoadReportController
{

  @Autowired
  private ServiceLoadReportService serviceLoadReportService;

  public static final String ADD_URL = "/add";

  @RequestMapping(value = ADD_URL, method = RequestMethod.GET)
  public ModelAndView addNewServiceLoadReportShow()
  {
    return MvHelper.get("reports/addReport");
  }

  public static final String SEARCH_URL = "/search";

  @RequestMapping(value = SEARCH_URL, method = RequestMethod.GET)
  public ModelAndView searchService()
  {
    return MvHelper.get("reports/serviceLoad/searchReport");
  }

  public static final String VIEW_URL = "/view/{id}";

  @RequestMapping(value = VIEW_URL, method = RequestMethod.GET)
  public ModelAndView viewService(@PathVariable Long id)
  {
    return MvHelper.get("reports/serviceLoad/viewReport").addObject(serviceLoadReportService.findById(id));
  }

  @ModelAttribute("allServiceLoadReports")
  public List<ServiceLoadReport> allServiceLoadReports() throws IllegalAccessException, InstantiationException
  {
    return serviceLoadReportService.loadAll();
  }
}
