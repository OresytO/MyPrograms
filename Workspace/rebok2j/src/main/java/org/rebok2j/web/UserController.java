package org.rebok2j.web;

import org.apache.log4j.Logger;
import org.rebok2j.domain.Domain;
import org.rebok2j.models.MyModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
@PreAuthorize("hasAnyRole('ROLE_USER', 'ROLE_ADMIN')")
public class UserController {
    private static Logger log = Logger.getLogger(UserController.class.getName());

    @Autowired
    private HttpServletRequest request;

/*    @Autowired
    @Qualifier("deliveryTypeService")
    private RebokService deliveryTypeService;

    @Autowired
    @Qualifier("authorizationService")
    private RebokService authorizationService;

    @Autowired
    @Qualifier("courierCompanyService")
    private RebokService courierCompanyService;

    @Autowired
    @Qualifier("deliveryService")
    private RebokService deliveryService;

    @Autowired
    @Qualifier("idTypeService")
    private RebokService idTypeService;

    @Autowired
    @Qualifier("locationService")
    private RebokService locationService;*/

    @Autowired
    @Qualifier("addNewDeliveryModel")
    private MyModel addNewDeliveryModel;
    private String returnUrl;

    @RequestMapping(value = "/adding", method = RequestMethod.POST, params = {"routeId", "routeType", "Name"})
    public String addingStopToRoute(@RequestParam(value = "routeId") Integer id, @RequestParam(value = "routeType") String routeType,
                                    @RequestParam(value = "Name") String name) {
        return "redirect:/";
    }

    @RequestMapping(value = "/addNewDelivery", method = RequestMethod.GET)
    public ModelAndView addNewDelivery() throws InstantiationException, IllegalAccessException {
        /*model.addAttribute("deliveryTypeDropDown", deliveryTypeService.fillElement("DeliveryType.findAll"));
        model.addAttribute("courierCompanyDropDown", courierCompanyService.fillElement("CourierCompany.findAll"));
        model.addAttribute("locationDropDown", locationService.fillElement("Location.findAll"));*/

        Map<String, Object> model = addNewDeliveryModel.getModel();
        /*for (DeliveryType dt : (List<DeliveryType>) model.get("deliveryTypeDropDown"))
            System.out.println(dt.getId());*/
        return new ModelAndView("user_addNewDelivery", model);
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/addNewSelectOption", method = RequestMethod.POST)
    public String addNewSelectOption(Model model) {
        System.out.println("!!!!!!!!test!!!!!!! -- " + System.currentTimeMillis());
        System.out.println("return URL -> " + request.getHeader("Referer").toString());
        Map<String, String[]> map = request.getParameterMap();
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

    @RequestMapping(value = "/editExistingDelivery")
    public String editExistingDelivery() {
        return "user_editExistingDelivery";
    }

    @RequestMapping(value = "/printAuthorization")
    public String printAutorization() {
        return "user_printAuthorization";
    }


}
