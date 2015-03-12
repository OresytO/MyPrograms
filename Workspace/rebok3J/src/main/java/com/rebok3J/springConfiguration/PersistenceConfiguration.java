package com.rebok3J.springConfiguration;

import com.rebok3J.model.User;
import com.rebok3J.model.Visit;
import com.rebok3J.model.Visitor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.support.ResourcePropertySource;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.EclipseLinkJpaVendorAdapter;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import java.io.IOException;
import java.util.Map;
import java.util.Properties;

/**
 * Created by OrestO
 * on 3/12/2015.
 */
@Configuration
@EnableJpaRepositories(basePackageClasses = { User.class, Visit.class, Visitor.class})
@EnableTransactionManagement
public class PersistenceConfiguration {

  public static final String JPA_PROPERTIES = "jpa.properties";
  public static final String PACKAGE_TO_SCAN = "com.rebok3J.model";

  @Bean
  public JpaTransactionManager transactionManager() throws IOException {
    JpaTransactionManager transactionManager = new JpaTransactionManager();
    transactionManager.setEntityManagerFactory(entityManagerFactory().getObject());
    return transactionManager;
  }

  @Bean
  public LocalContainerEntityManagerFactoryBean entityManagerFactory() throws IOException {
    LocalContainerEntityManagerFactoryBean entityManagerFactory = new LocalContainerEntityManagerFactoryBean();

    entityManagerFactory.setJpaVendorAdapter(new EclipseLinkJpaVendorAdapter());
    entityManagerFactory.setPackagesToScan(PACKAGE_TO_SCAN);

    ResourcePropertySource propertySource = new ResourcePropertySource(JPA_PROPERTIES, new ClassPathResource(JPA_PROPERTIES));

    Properties jpaProperties = new Properties();

    Map<String, Object> properties = propertySource.getSource();
    for (String propertyName : properties.keySet()) {
      jpaProperties.put(propertyName, properties.get(propertyName));
    }
    entityManagerFactory.setJpaProperties(jpaProperties);

    return entityManagerFactory;
  }

}