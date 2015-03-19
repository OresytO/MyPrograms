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
    return "login";
  }
}
