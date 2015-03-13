package com.rebok3J.springConfiguration;

import java.io.IOException;
import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.EclipseLinkJpaVendorAdapter;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.rebok3J.model.impl.UserImpl;
import com.rebok3J.model.impl.VisitImpl;
import com.rebok3J.model.impl.VisitorImpl;

/**
 * Created by OrestO on 3/12/2015.
 */
@Configuration
@EnableJpaRepositories(basePackageClasses = { UserImpl.class, VisitImpl.class, VisitorImpl.class })
@EnableTransactionManagement
public class PersistenceConfiguration
{

  // TODO: why don't work?
  public static final String JPA_PROPERTIES = "jpa.properties";
  public static final String PACKAGE_TO_SCAN = "com.rebok3J.model";

  @Bean
  public JpaTransactionManager transactionManager() throws IOException
  {
    JpaTransactionManager transactionManager = new JpaTransactionManager();
    transactionManager.setEntityManagerFactory(entityManagerFactory().getObject());
    return transactionManager;
  }

  @Bean
  // TODO: Make it works and looks nice :)
  public LocalContainerEntityManagerFactoryBean entityManagerFactory() throws IOException
  {
    LocalContainerEntityManagerFactoryBean entityManagerFactory = new LocalContainerEntityManagerFactoryBean();

    entityManagerFactory.setJpaVendorAdapter(new EclipseLinkJpaVendorAdapter());
    entityManagerFactory.setPackagesToScan(PACKAGE_TO_SCAN);

    // ResourcePropertySource propertySource = new
    // ResourcePropertySource(JPA_PROPERTIES, new
    // ClassPathResource(JPA_PROPERTIES));

    Properties jpaProperties = new Properties();

    // Map<String, Object> properties = propertySource.getSource();
    // for (String propertyName : properties.keySet()) {
    // jpaProperties.put(propertyName, properties.get(propertyName));
    // }
    jpaProperties.put("javax.persistence.jdbc.driver", "org.postgresql.Driver");
    jpaProperties.put("javax.persistence.jdbc.url", "jdbc:postgresql://localhost:5432/rebok3J_DB");
    jpaProperties.put("javax.persistence.jdbc.user", "postgres");
    jpaProperties.put("javax.persistence.jdbc.password", "njvfmkcd@2410@");
    jpaProperties.put("eclipselink.weaving", "false");
    entityManagerFactory.setJpaProperties(jpaProperties);

    return entityManagerFactory;
  }

}