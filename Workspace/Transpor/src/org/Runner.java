package org;

import org.eclipse.jetty.server.Connector;
import org.eclipse.jetty.server.Handler;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.ServerConnector;
import org.eclipse.jetty.server.handler.HandlerCollection;
import org.eclipse.jetty.webapp.WebAppContext;

public class Runner {
    public static void main(String[] args) throws Exception {
        Server server = new Server(8080);

        Connector connector = new ServerConnector(server);
        server.addConnector(connector);

        WebAppContext root = new WebAppContext("root/src/main/webapp", "/");

        HandlerCollection handlers = new HandlerCollection();
        handlers.setHandlers(new Handler[] { root });
        server.setHandler(handlers);
        server.start();
    }
}
