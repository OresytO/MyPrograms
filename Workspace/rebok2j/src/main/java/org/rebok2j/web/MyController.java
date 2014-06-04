package org.rebok2j.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MyController extends AbstractControler {
    private static Logger log = Logger.getLogger(MyController.class.getName());

    @Autowired
    private HttpServletRequest request;

    private String returnUrl;

    @RequestMapping(value = "/adding", method = RequestMethod.POST, params = { "routeId", "routeType", "Name" })
    public String addingStopToRoute(@RequestParam(value = "routeId") Integer id, @RequestParam(value = "routeType") String routeType,
            @RequestParam(value = "Name") String name) {
        return "redirect:/";
    }

    @RequestMapping(value = { "/", "/welcome" }, method = RequestMethod.GET)
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
        System.out.println("!!!!!!!!test!!!!!!! -- " + System.currentTimeMillis());
        System.out.println("return URL -> " + request.getHeader("Referer").toString());
        Map<String, Object> map = request.getParameterMap();
        for (String obj : map.keySet()) {
            System.out.println(obj.toString() + " -> " + map.get(obj).toString());
        }
        returnUrl = request.getHeader("Referer");
        model.addAttribute("returnUrl", returnUrl);
        return "user_addNewSelectOption";
    }

    @RequestMapping(value = "/addNewSelectOption/{param}", method = RequestMethod.POST)
    public String add(@PathVariable String param, Model model) {
        System.out.println("param -> " + param);
        if (!param.equals("add") && !param.equals("back")) {
            throw new IllegalArgumentException("Unknown parameter!!!");
        } else if (param.equals("add")) {
            // adding data to DB
        }
        System.out.println("returnUrl -> " + returnUrl);
        return "redirect:" + returnUrl;
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

    // private String transformUrl(String url) {
    // String tempUrl = returnUrl.substring(returnUrl.lastIndexOf("/" + url));
    // System.out.println(tempUrl);
    // return tempUrl;
    // }

}
