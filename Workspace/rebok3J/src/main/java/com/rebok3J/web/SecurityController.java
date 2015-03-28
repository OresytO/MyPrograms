package com.rebok3J.web;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 *
 * @author OrestO
 * @since 3/11/2015
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

  @PreAuthorize("isAuthenticated()")
  @RequestMapping(value = { HOME_URL, "/" }, method = RequestMethod.GET)
  public ModelAndView showHome()
  {
    return MvHelper.get("layout/content::content");
  }

  public static final String DENIED_URL = "/denied";

  @RequestMapping(value = DENIED_URL, method = RequestMethod.GET)
  public String showDenied()
  {
    return "security/denied";
  }

  public static final String FAILURE_URL = "/failure";

  @RequestMapping(value = FAILURE_URL, method = RequestMethod.GET)
  public String showFailure()
  {
    return "security/failure";
  }

}
