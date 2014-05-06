package org.orest.transport.mvc;

import java.util.List;

import org.orest.transport.domain.Vehicle;
import org.orest.transport.repo.Dao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TransportController {

    @Autowired
    private Dao dao;

    /**
     * This handler method is invoked when http://localhost:8080/pizzashop is requested. The method returns view name "index" which will be resolved into
     * /WEB-INF/index.jsp. See src/main/webapp/WEB-INF/servlet-context.xml
     */
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String list(Model model) {
        // List<Vehicle> vehicles = (List<Vehicle>) dao.findAllVehicles(Bus.class);
        // vehicles.addAll(dao.findAllVehicles(Tramway.class));
        // vehicles.addAll(dao.findAllVehicles(Subway.class));
        // vehicles.addAll(dao.findAllVehicles(Trolleybus.class));

        List<Vehicle> vehicles = (List<Vehicle>) dao.findAllVehicles(Vehicle.class);
        model.addAttribute("vehicles", vehicles);
        return "index";
    }
}
