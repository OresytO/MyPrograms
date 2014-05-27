package org.rebok2j.web;

import org.apache.log4j.Logger;
import org.rebok2j.service.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MyController extends AbstractControler {
    private static Logger log = Logger.getLogger(MyController.class.getName());

    @Autowired
    private Service service;

    @RequestMapping(value = "/adding", method = RequestMethod.POST, params = { "routeId", "routeType", "Name" })
    public String addingStopToRoute(@RequestParam(value = "routeId") Integer id, @RequestParam(value = "routeType") String routeType,
            @RequestParam(value = "Name") String name) {
        return "redirect:/";
    }

    @RequestMapping(value = { "/", "/welcome" })
    public String index() {
        return "welcome";
    }

    @RequestMapping(value = "/login")
    public String signin() {
        return "login";
    }

    // @RequestMapping(value = "/user_addNewDelivery")
    public String addNewDelivery() {
        return "addNewDelivery";
    }

    @RequestMapping(value = "/user_editExistingDelivery")
    public String editExistingDelivery() {
        return "editExistingDelivery";
    }

    @RequestMapping(value = "/user_printAutorization")
    public String printAutorization() {
        return "user_printAutorization";
    }

    @RequestMapping(value = "/denied")
    public String denied() {
        return "denied";
    }

}
