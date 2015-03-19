package springConfiguration;

import javax.servlet.ServletContext;
import javax.servlet.ServletRegistration;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

/**
 * Created by OrestO on 3/12/2015.
 */

public class ApplicationInitializer implements WebApplicationInitializer
{

  @Override
  public void onStartup(ServletContext container)
  {
    // Create the 'root' Spring application context
    AnnotationConfigWebApplicationContext rootContext = new AnnotationConfigWebApplicationContext();
    rootContext.register(JavaBaseSpringConfiguration.class);

    // Manage the lifecycle of the root application context
    container.addListener(new ContextLoaderListener(rootContext));

    // Create the dispatcher servlet's Spring application context
//    AnnotationConfigWebApplicationContext dispatcherContext = new AnnotationConfigWebApplicationContext();
//    dispatcherContext.register(DispatcherConfig.class);

    // Register and map the dispatcher servlet
//    ServletRegistration.Dynamic dispatcher = container.addServlet("dispatcher", new DispatcherServlet(dispatcherContext));
    ServletRegistration.Dynamic dispatcher = container.addServlet("dispatcher1", new DispatcherServlet(rootContext));
    dispatcher.setLoadOnStartup(1);
    dispatcher.addMapping("/");
  }

}