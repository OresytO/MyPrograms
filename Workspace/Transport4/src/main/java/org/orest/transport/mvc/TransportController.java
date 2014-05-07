package org.orest.transport.mvc;

import java.util.List;

import org.orest.transport.domain.Bus;
import org.orest.transport.domain.Subway;
import org.orest.transport.domain.Tramway;
import org.orest.transport.domain.Trolleybus;
import org.orest.transport.domain.Vehicle;
import org.orest.transport.repo.Dao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class TransportController {

    @Autowired
    private Dao dao;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String displayingListOfVehiclesAndStops(Model model) {
        System.out.println("GET");
        List<? extends Vehicle> vehicles = dao.findAllVehicles(Bus.class);
        model.addAttribute("buses", vehicles);
        vehicles = dao.findAllVehicles(Tramway.class);
        model.addAttribute("tramwayes", vehicles);
        vehicles = dao.findAllVehicles(Subway.class);
        model.addAttribute("subwayes", vehicles);
        vehicles = dao.findAllVehicles(Trolleybus.class);
        model.addAttribute("trolleybuses", vehicles);

        return "index";
    }

    @RequestMapping(value = "/", method = RequestMethod.POST, params = { "vechicleId", "vechicleType", "Name" })
    public String addingStopToRoute(@RequestParam(value = "vechicleId") Integer id, @RequestParam(value = "vechicleType") String vehicleType,
            @RequestParam(value = "Name") String name, Model model) {
        if (name.length() == 0)
            throw new IllegalArgumentException("empty name!");
        System.out.println("POST");
        String res = dao.addStop(id, getType(vehicleType), name);
        System.out.println("res " + res);
        return "redirect:/";
    }

    private Class<? extends Vehicle> getType(String vehicleType) {
        if (vehicleType.equalsIgnoreCase("bus"))
            return Bus.class;
        if (vehicleType.equalsIgnoreCase("tramway"))
            return Tramway.class;
        if (vehicleType.equalsIgnoreCase("trolleybus"))
            return Trolleybus.class;
        if (vehicleType.equalsIgnoreCase("subway"))
            return Subway.class;
        throw new IllegalArgumentException("unsupported vehicle type!");
    }
}
