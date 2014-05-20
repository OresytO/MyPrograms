package org.rebok2j.web;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.rebok2j.service.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MyController extends AbstractControler {
    private static Logger log = Logger.getLogger(MyController.class.getName());

    @Autowired
    private Service service;

    // @RequestMapping(value = "/", method = RequestMethod.GET)
    public String welcomePage(Model model) {
        service.getAutorazation(1L);
        List<String> list = new ArrayList<String>();
        list.add("United Stated");
        list.add("China");
        list.add("Singapore");
        list.add("Malaysia");
        addition(list);
        model.addAttribute("countryList", list);
        return "index";
    }

    @RequestMapping(value = "/adding", method = RequestMethod.POST, params = { "routeId", "routeType", "Name" })
    public String addingStopToRoute(@RequestParam(value = "routeId") Integer id, @RequestParam(value = "routeType") String routeType, @RequestParam(value = "Name") String name) {
        return "redirect:/";
    }

    @RequestMapping(value = { "/", "/welcome**" }, method = RequestMethod.GET)
    public ModelAndView welcomePage() {

        ModelAndView model = new ModelAndView();
        model.addObject("title", "Spring Security Hello World");
        model.addObject("message", "This is welcome page!");
        model.setViewName("hello");
        return model;

    }

    @RequestMapping(value = "/admin**", method = RequestMethod.GET)
    public ModelAndView adminPage() {

        ModelAndView model = new ModelAndView();
        model.addObject("title", "Spring Security Hello World");
        model.addObject("message", "This is protected page!");
        model.setViewName("admin");

        return model;

    }
}
