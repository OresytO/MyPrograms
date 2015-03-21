package springConfiguration;

import java.util.Locale;

import nz.net.ultraq.thymeleaf.LayoutDialect;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.thymeleaf.extras.springsecurity3.dialect.SpringSecurityDialect;
import org.thymeleaf.spring4.SpringTemplateEngine;
import org.thymeleaf.spring4.view.ThymeleafViewResolver;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;

/**
 * Created by OrestO on 3/11/2015.
 */

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "com.rebok3J")
@Import({ PersistenceConfiguration.class, SpringSecurityConfiguration.class })
public class JavaBaseSpringConfiguration extends WebMvcConfigurerAdapter
{

  @Override
  public void addResourceHandlers(ResourceHandlerRegistry registry)
  {
    registry.addResourceHandler("/resources/**").addResourceLocations("/resources/").setCachePeriod(31556926);
    // registry.addResourceHandler("/webapp/**").addResourceLocations("/webapp/").setCachePeriod(31556926);
  }

  // @Override
  // public void configureViewResolvers(ViewResolverRegistry registry)
  // {
  // registry.enableContentNegotiation(new MappingJackson2JsonView());
  // registry.jsp();
  // }
  //

  @Bean
  public ServletContextTemplateResolver templateResolver()
  {
    ServletContextTemplateResolver resolver = new ServletContextTemplateResolver();
    resolver.setPrefix("/WEB-INF/views/");
    resolver.setSuffix(".html");
    resolver.setTemplateMode("HTML5");
    resolver.setCacheable(false);
    return resolver;
  }

  @Bean
  public SpringTemplateEngine templateEngine()
  {
    SpringTemplateEngine engine = new SpringTemplateEngine();
    engine.setTemplateResolver(templateResolver());
    engine.addDialect(new SpringSecurityDialect());
    engine.addDialect(new LayoutDialect());
    return engine;
  }

  @Bean
  public ThymeleafViewResolver thymeleafViewResolver()
  {
    ThymeleafViewResolver viewResolver = new ThymeleafViewResolver();
    viewResolver.setCharacterEncoding("UTF-8");
    viewResolver.setTemplateEngine(templateEngine());
    viewResolver.setOrder(1);
    // viewResolver.setViewNames(new String[]{"th_*"});
    return viewResolver;
  }

  // @Bean
  // public InternalResourceViewResolver jspViewResolver()
  // {
  // InternalResourceViewResolver bean = new InternalResourceViewResolver();
  // bean.setViewClass(JstlView.class);
  // bean.setPrefix("/WEB-INF/views/");
  // bean.setSuffix(".jsp");
  // bean.setOrder(2);
  // bean.setViewNames("*jsp");
  // return bean;
  // }

  @Bean
  public CookieLocaleResolver localeResolver()
  {
    CookieLocaleResolver resolver = new CookieLocaleResolver();
    resolver.setDefaultLocale(new Locale("ua"));
    return resolver;
  }

  @Bean
  public LocaleChangeInterceptor localeChangeInterceptor()
  {
    LocaleChangeInterceptor interceptor = new LocaleChangeInterceptor();
    interceptor.setParamName("lang");
    return interceptor;
  }

  @Bean
  public MessageSource messageSource() {
    ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
    messageSource.setBasename("WEB-INF/messages/messages");
    messageSource.setDefaultEncoding("UTF-8");
    messageSource.setUseCodeAsDefaultMessage(true);
    return messageSource;
  }

  public void addInterceptors(InterceptorRegistry registry) {
    registry.addInterceptor(localeChangeInterceptor());
  }
}
