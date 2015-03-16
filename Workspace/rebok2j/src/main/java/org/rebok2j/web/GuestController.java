package org.rebok2j.web;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@PreAuthorize("permitAll")
public class GuestController {
/*    private static Logger log = Logger.getLogger(GuestController.class);*/

  @RequestMapping(value = {"/", "/welcome"}, method = RequestMethod.GET)
  public String index() {
    return "welcome";
//    return "views/tiles/welcome.jsp";
  }

}
