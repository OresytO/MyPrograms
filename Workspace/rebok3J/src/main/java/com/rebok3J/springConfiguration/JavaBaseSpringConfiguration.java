package com.rebok3J.springConfiguration;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import java.util.Locale;

/**
 * Created by OrestO on 3/11/2015.
 */

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "com.rebok3J.*")
@Import({PersistenceConfiguration.class/*, SpringSecurityConfiguration.class*/})
public class JavaBaseSpringConfiguration extends WebMvcConfigurerAdapter
{

  @Override
  public void addResourceHandlers(ResourceHandlerRegistry registry) {
    registry.addResourceHandler("/resources/**").addResourceLocations("/resources/").setCachePeriod(31556926);
    registry.addResourceHandler("/webapp/**").addResourceLocations("/webapp/").setCachePeriod(31556926);
  }

  @Override
  public void configureViewResolvers(ViewResolverRegistry registry) {
    registry.enableContentNegotiation(new MappingJackson2JsonView());
    registry.jsp();
  }

  @Bean
  public InternalResourceViewResolver jspViewResolver() {
    InternalResourceViewResolver bean = new InternalResourceViewResolver();
    bean.setPrefix("/WEB-INF/views/");
    bean.setSuffix(".jsp");
    return bean;
  }

  @Bean
  public MessageSource messageSource()
  {
    ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
    messageSource.setBasename("resources/messages");// "classpath:messages"
    messageSource.setUseCodeAsDefaultMessage(true);
    messageSource.setDefaultEncoding("UTF-8");
    return messageSource;
  }


  @Bean
  public LocaleChangeInterceptor localeChangeInterceptor() {
    LocaleChangeInterceptor interceptor = new LocaleChangeInterceptor();
    interceptor.setParamName("lang");
    return interceptor;
  }

  @Bean
  public CookieLocaleResolver localeResolver() {
    CookieLocaleResolver resolver = new CookieLocaleResolver();
    resolver.setDefaultLocale(new Locale("ua"));
    return resolver;
  }
}
