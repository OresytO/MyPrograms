package org.rebok2j.web;

import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.rebok2j.service.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MyController extends AbstractControler {
    private static Logger log = Logger.getLogger(MyController.class.getName());

    @Autowired
    private Service service;

    @Autowired
    private HttpServletRequest request;

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

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/addNewSelectOption", method = RequestMethod.POST)
    public String addNewSelectOption(Model model) {
        Map<String, List<String>> parMap = new TreeMap<>();
        System.out.println("!!!!!!!!test!!!!!!! -- " + System.currentTimeMillis());
        System.out.println("return URL -> " + request.getHeader("Referer").toString());
        Map<String, Object> map = request.getParameterMap();
        for (String obj : map.keySet()) {
            System.out.println(obj.toString() + " -> " + map.get(obj).toString());
        }
        model.addAttribute("returnUrl", request.getHeader("Referer"));
        model.addAttribute("returnUrl", request.getHeader("Referer"));
        return "user_dates";
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
