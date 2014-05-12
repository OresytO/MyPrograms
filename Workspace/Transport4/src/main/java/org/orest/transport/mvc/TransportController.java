package org.orest.transport.mvc;

import java.util.List;

import org.apache.log4j.Logger;
import org.orest.transport.domain.BusRoute;
import org.orest.transport.domain.Route;
import org.orest.transport.domain.SubwayRoute;
import org.orest.transport.domain.TramwayRoute;
import org.orest.transport.domain.TrolleybusRoute;
import org.orest.transport.repo.Dao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class TransportController {

    private static Logger log = Logger.getLogger(TransportController.class.getName());

    @Autowired
    private Dao dao;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String displayingListOfRoutesAndStops(Model model) {
        List<? extends Route> routes = dao.findAllRoutes(BusRoute.class);
        model.addAttribute("buses", routes);
        routes = dao.findAllRoutes(TramwayRoute.class);
        model.addAttribute("tramwayes", routes);
        routes = dao.findAllRoutes(SubwayRoute.class);
        model.addAttribute("subwayes", routes);
        routes = dao.findAllRoutes(TrolleybusRoute.class);
        model.addAttribute("trolleybuses", routes);
        log.info("index");
        System.out.println("111");
        return "index";
    }

    @RequestMapping(value = "/adding", method = RequestMethod.POST, params = { "routeId", "routeType", "Name" })
    public String addingStopToRoute(@RequestParam(value = "routeId") Integer id, @RequestParam(value = "routeType") String routeType,
            @RequestParam(value = "Name") String name) {
        if (name.length() == 0)
            throw new IllegalArgumentException("empty name!");
        dao.addStop(id, getType(routeType), name);
        log.warn("redirect:/");
        return "redirect:/";
    }

    @RequestMapping(value = "/removeStop", method = RequestMethod.POST, params = { "routeId", "routeType", "Name" })
    public String removeStop(@RequestParam(value = "routeId") Integer id, @RequestParam(value = "routeType") String routeType,
            @RequestParam(value = "Name") String stopName) {
        if (stopName.length() == 0)
            throw new IllegalArgumentException("empty name!");
        dao.removeStopFromRoute(id, getType(routeType), stopName);
        log.error("redirect:/");
        return "redirect:/";
    }

    @RequestMapping(value = "/addRoute", method = RequestMethod.POST, params = { "numOfRoute", "routeType" })
    public String addRoute(@RequestParam(value = "numOfRoute") String numOfRoute, @RequestParam(value = "routeType") String routeType) {
        if (numOfRoute.length() == 0)
            throw new IllegalArgumentException("empty number of route!");
        dao.addRoute(getType(routeType), numOfRoute);
        log.debug("redirect:/");
        return "redirect:/";
    }

    @RequestMapping(value = "/removeRoute", method = RequestMethod.POST, params = { "numOfRoute", "routeType" })
    public String removeRoute(@RequestParam(value = "numOfRoute") String numOfRoute, @RequestParam(value = "routeType") String routeType) {
        if (numOfRoute.length() == 0)
            throw new IllegalArgumentException("empty number of route!");
        dao.removeRoute(getType(routeType), numOfRoute);
        log.info("redirect:/");
        return "redirect:/";
    }

    private Class<? extends Route> getType(String vehicleType) {
        if (vehicleType.equalsIgnoreCase("busRoute"))
            return BusRoute.class;
        if (vehicleType.equalsIgnoreCase("tramwayRoute"))
            return TramwayRoute.class;
        if (vehicleType.equalsIgnoreCase("trolleybusRoute"))
            return TrolleybusRoute.class;
        if (vehicleType.equalsIgnoreCase("subwayRoute"))
            return SubwayRoute.class;
        throw new IllegalArgumentException("unsupported vehicle type!");
    }
}
