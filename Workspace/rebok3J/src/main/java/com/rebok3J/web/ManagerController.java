package com.rebok3J.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.rebok3J.dao.UserDao;

/**
 * Created by OrestO on 3/11/2015.
 */
@Controller
@RequestMapping(value = "/manager**")
@PreAuthorize("hasRole('manager') or hasRole('admin')")
public class ManagerController
{

  @Autowired
  private UserDao userDao;

  public static final String SHOW_USERS_URL = "/showUsers";
  public static final String USERS_LIST = "usersList";

  @RequestMapping(value = SHOW_USERS_URL, method = RequestMethod.GET)
  public String showUsers(Model model) throws InstantiationException, IllegalAccessException
  {
    model.addAttribute(USERS_LIST, userDao.loadAll());
    model.addAttribute("controller", "MANAGER CONTROLLER");
    return "manager/test";
  }
}
