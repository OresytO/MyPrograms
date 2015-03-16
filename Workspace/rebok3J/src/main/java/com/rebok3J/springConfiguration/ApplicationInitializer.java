package com.rebok3J.springConfiguration;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

/**
 * Created by OrestO on 3/12/2015.
 */

public class ApplicationInitializer extends AbstractAnnotationConfigDispatcherServletInitializer
{

  @Override
  protected Class<?>[] getRootConfigClasses()
  {
    return new Class[] { JavaBaseSpringConfiguration.class, PersistenceConfiguration.class, SpringSecurityConfiguration.class };
  }

  @Override
  protected Class<?>[] getServletConfigClasses()
  {
    return new Class[] { JavaBaseSpringConfiguration.class, PersistenceConfiguration.class, SpringSecurityConfiguration.class };
  }

  @Override
  protected String[] getServletMappings()
  {
    return new String[] { "/" };
  }

}