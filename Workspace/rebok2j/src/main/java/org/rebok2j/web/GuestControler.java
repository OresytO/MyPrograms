package org.rebok2j.web;

import org.apache.log4j.Logger;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@PreAuthorize("permitAll")
public class GuestControler {
    private static Logger log = Logger.getLogger(GuestControler.class.getName());

    @RequestMapping(value = { "/", "/welcome" }, method = RequestMethod.GET)
    public String index() {
        return "welcome";
    }

}
