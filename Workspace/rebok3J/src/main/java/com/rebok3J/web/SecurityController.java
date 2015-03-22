package com.rebok3J.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by OrestO on 3/11/2015.
 */
@Controller
public class SecurityController
{

  public static final String LOGIN_URL = "/login";
  @RequestMapping(value = LOGIN_URL, method = RequestMethod.GET)
  public String showUsers()
  {
    return "security/login";
  }

  public static final String HOME_URL = "/home";
  @RequestMapping(value = {HOME_URL, "/"}, method = RequestMethod.GET)
  public String showHome()
  {
    return "layout/layout";
  }

  public static final String DENIED_URL = "/denied";
  @RequestMapping(value = DENIED_URL, method = RequestMethod.GET)
  public String showDenied()
  {
    return "security/denied";
  }

  public static final String LOGOUT_URL = "/logout";
  @RequestMapping(value = LOGOUT_URL, method = RequestMethod.GET)
  public String showLogout()
  {
    return "security/login";
  }

  public static final String FAILURE_URL = "/failure";
  @RequestMapping(value = FAILURE_URL, method = RequestMethod.GET)
  public String showFailure()
  {
    return "security/failure";
  }

}
