package org.rebok2j.web;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.rebok2j.service.RebokService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;

@Controller
@PreAuthorize("hasRole('ROLE_ADMIN')")
public class AdminControler {
    private static Logger log = Logger.getLogger(AdminControler.class.getName());

    @Autowired
    private HttpServletRequest request;

    @Autowired
    @Qualifier("deliveryTypeService")
    private RebokService deliveryTypeService;

    private String returnUrl;

}
