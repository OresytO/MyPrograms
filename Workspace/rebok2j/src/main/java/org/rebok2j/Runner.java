package org.rebok2j;

public class Runner {

    public static void main(String[] args) throws Exception {
       /* Server server = new Server(8080);

        Connector connector = new ServerConnector(server);
        server.addConnector(connector);
        ContextHandlerCollection contexts = new ContextHandlerCollection();

        WebAppContext webAppContext = new WebAppContext();//("rebok2j/src/main/webapp", "/");
        webAppContext.setDescriptor("rebok2j/src/main/webapp/WEB-INF/web.xml");
        webAppContext.setResourceBase(".");
        webAppContext.setContextPath("/");

        contexts.setHandlers(new Handler[]{webAppContext});
        server.setHandler(webAppContext);*/

        /*ContextHandlerCollection contexts = new ContextHandlerCollection();
        WebAppContext webAppContext = new WebAppContext();
        webAppContext.setDescriptor("rebok2j/src/main/webapp/WEB-INF/web.xml");
        webAppContext.setResourceBase(".");
        webAppContext.setContextPath("/");
        Collection<Object> listWebAppContext = new ArrayList<>();
        listWebAppContext.add(webAppContext);
        contexts.setBeans(listWebAppContext);

        QueuedThreadPool threadPool = new org.eclipse.jetty.util.thread.QueuedThreadPool();
        threadPool.setMinThreads(10);
        threadPool.setMaxThreads(50);

        Server server = new Server(threadPool);

        ServerConnector serverConnector = new ServerConnector(server);
        serverConnector.setPort(8080);
        server.setConnectors(new Connector[]{serverConnector});

        HandlerCollection handlerCollection = new HandlerCollection();
        handlerCollection.setHandlers(new Handler[]{contexts, new DefaultHandler()});
        server.setHandler(handlerCollection);

        DeploymentManager deploymentManager = new DeploymentManager();
        deploymentManager.setContexts(contexts);

        WebAppProvider webAppProvider = new WebAppProvider();
        webAppProvider.setMonitoredDirName("webapps");
        webAppProvider.setScanInterval(1);
        webAppProvider.setExtractWars(true);

        Collection<AppProvider> listAppProvider = new ArrayList<>();
        listAppProvider.add(webAppProvider);
        deploymentManager.setAppProviders(listAppProvider);

        Collection<Object> listObject = new ArrayList<>();
        listObject.add(deploymentManager);
        server.setBeans(listObject);*/

        /*server.start();
        server.join();*/

    }
}
