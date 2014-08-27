package org.rebok2j.configuration;

import org.rebok2j.domain.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.core.env.PropertySource;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.EclipseLinkJpaVendorAdapter;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import java.util.Properties;

/**
 * Created by OrestO
 * on 6/28/2014.
 */
@Configuration
@EnableJpaRepositories(basePackageClasses = {Authorization.class, CourierCompany.class, Delivery.class, DeliveryType.class, IdType.class,
  Location.class, Role.class, Staff.class, User.class})
@EnableTransactionManagement
//@PropertySource("classpath:jpa.properties")
public class PersistenceConfiguration {

  @Bean
  public JpaTransactionManager transactionManager() {
    JpaTransactionManager transactionManager = new JpaTransactionManager();
    transactionManager.setEntityManagerFactory(entityManagerFactory().getObject());
    return transactionManager;
  }

  @Bean
  public LocalContainerEntityManagerFactoryBean entityManagerFactory() {
    LocalContainerEntityManagerFactoryBean entityManagerFactory = new LocalContainerEntityManagerFactoryBean();

    entityManagerFactory.setJpaVendorAdapter(new EclipseLinkJpaVendorAdapter());
    entityManagerFactory.setPackagesToScan("org.rebok2j.domain");

    PropertySource propertySource = propertyPlaceHolderConfigurer().getAppliedPropertySources().get("classpath:jpa.properties");//"classpath:jpa.properties

    Properties jpaProperties = new Properties();
    /*<property name="persistenceXmlLocation" value="classpath:/META-INF/persistence.xml" />
    <property name="persistenceUnitName" value="primary" />*/


    String[] arr = {"javax.persistence.jdbc.driver", "javax.persistence.jdbc.url", "javax.persistence.jdbc.user", "javax.persistence.jdbc.password",
      "javax.persistence.schema-generation.create-source", "javax.persistence.schema-generation.drop-source",
      "javax.persistence.schema-generation.create-script-source", "javax.persistence.schema-generation.drop-script-source",
      "javax.persistence.sql-load-script-source", "javax.persistence.schema-generation.database.action", "eclipselink.weaving"};
    for (String propertyName : arr) {
      jpaProperties.put(propertyName, propertySource.getProperty(propertyName));
    }
    entityManagerFactory.setJpaProperties(jpaProperties);

    return entityManagerFactory;
  }

  @Bean
  public PropertySourcesPlaceholderConfigurer propertyPlaceHolderConfigurer() {
    PropertySourcesPlaceholderConfigurer configurer = new PropertySourcesPlaceholderConfigurer();
    //configurer.setLocation(new ClassPathResource("classpath:jpa.properties"));
    return configurer;
  }
}
