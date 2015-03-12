package com.rebok3J.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.rebok3J.dao.impl.DaoAbstract;
import com.rebok3J.dao.impl.VisitDaoImpl;
import com.rebok3J.dao.impl.VisitorDaoImpl;
import com.rebok3J.model.User;

/**
 * Created by OrestO on 3/11/2015.
 */
@Controller
public class FirstController
{

  @Autowired
  private DaoAbstract<User> userDao;

  @Autowired
  private VisitDaoImpl visitDao;

  @Autowired
  private VisitorDaoImpl visitorDao;

  public static final String SHOW_USERS_URL = "/showUsers";
  public static final String USERS_LIST = "usersList";

  @RequestMapping(name = SHOW_USERS_URL, method = RequestMethod.GET)
  public String showUsers(Model model) throws InstantiationException, IllegalAccessException
  {
    model.addAttribute(USERS_LIST, userDao.loadAll());
    return "home.jsp";
  }
}
