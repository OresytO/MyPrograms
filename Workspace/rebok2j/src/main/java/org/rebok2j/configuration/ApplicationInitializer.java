package org.rebok2j.configuration;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

/**
 * Created by OrestO
 * on 6/28/2014.
 */
public class ApplicationInitializer implements WebApplicationInitializer {
  @Override
  public void onStartup(ServletContext servletContext) throws ServletException {
    WebApplicationContext context = getContext(servletContext);
    servletContext.addListener(new ContextLoaderListener(context));
    ServletRegistration.Dynamic dispatcher = servletContext.addServlet("applicationServlet", new DispatcherServlet(context));
    dispatcher.setLoadOnStartup(1);
    dispatcher.addMapping("/");
  }

  private AnnotationConfigWebApplicationContext getContext(ServletContext servletContext) {
    AnnotationConfigWebApplicationContext context = new AnnotationConfigWebApplicationContext();
    context.setConfigLocation("org.rebok2j.configuration");
    /*context.setConfigLocation("/WEB-INF/spring/root-context.xml");*/
    context.register(WebMvcConfiguration.class);
    context.setServletContext(servletContext);
    return context;
  }
}
