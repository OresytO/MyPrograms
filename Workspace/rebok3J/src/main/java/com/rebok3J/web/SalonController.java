package com.rebok3J.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.rebok3J.model.impl.Salon;
import com.rebok3J.services.SalonService;
import com.rebok3J.web.forms.AddNewSalonDTO;

/**
 *
 *
 * @author OrestO
 * @since 3/11/2015
 */
@Controller
@RequestMapping(value = "/salon**")
public class SalonController
{

  @Autowired
  private SalonService salonService;

  public static final String ADD_URL = "/add";

  @RequestMapping(value = ADD_URL, method = RequestMethod.GET)
  public ModelAndView addNewSalonShow(@ModelAttribute AddNewSalonDTO addNewSalonDTO)
  {
    return MvHelper.get("salon/addSalon");
  }

  @RequestMapping(value = ADD_URL, method = RequestMethod.POST)
  public ModelAndView addNewSalon(@ModelAttribute AddNewSalonDTO addNewSalonDTO)
  {
    salonService.save(addNewSalonDTO.getEntity());
    return MvHelper.get("salon/viewSalon");
  }

  public static final String SEARCH_URL = "/search";

  @RequestMapping(value = SEARCH_URL, method = RequestMethod.GET)
  public ModelAndView searchSalonShow()
  {
    return MvHelper.get("salon/searchSalon");
  }

  public static final String VIEW_URL = "/view/{id}";

  @RequestMapping(value = VIEW_URL, method = RequestMethod.GET)
  public ModelAndView viewSalon(@PathVariable Long id)
  {
    return MvHelper.get("salon/viewSalon").addObject(salonService.findById(id));
  }

  @ModelAttribute("allSalons")
  public List<Salon> allSalons() throws IllegalAccessException, InstantiationException
  {
    return salonService.loadAll();
  }
}
