package org.rebok2j.web;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;

@Controller
@PreAuthorize("hasRole('ROLE_ADMIN')")
public class AdminController {
    /*private static Logger log = Logger.getLogger(AdminController.class.getName());

    @Autowired
    private HttpServletRequest request;

    private String returnUrl;*/

}
