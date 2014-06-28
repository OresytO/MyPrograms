package org.rebok2j.web;

import org.apache.log4j.Logger;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@PreAuthorize("permitAll")
public class SecurityController {
    private static Logger log = Logger.getLogger(SecurityController.class.getName());

    @RequestMapping(value = "/login")
    public String signin() {
        log.info("+++++++++++++++++++++++++++++++++++++++++ security_login");
        return "security_login";
    }

    @RequestMapping(value = "/denied")
    public String denied() {
        log.info("+++++++++++++++++++++++++++++++++++++++++ security_denied");
        return "security_denied";
    }

}
