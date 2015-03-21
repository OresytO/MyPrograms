package com.rebok3J.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.rebok3J.dao.UserDao;

/**
 * Created by OrestO on 3/11/2015.
 */
@Controller
@RequestMapping(value = "/director**")
public class DirectorController
{

  @Autowired
  private UserDao userDao;

  public static final String SHOW_USERS_URL = "/showUsers";
  public static final String USERS_LIST = "usersList";

  @RequestMapping(value = SHOW_USERS_URL, method = RequestMethod.GET)
  public String showUsers(Model model) throws InstantiationException, IllegalAccessException
  {
    model.addAttribute(USERS_LIST, userDao.loadAll());
    model.addAttribute("controller", "DIRECTOR CONTROLLER");
    return "director/test";
  }
}
