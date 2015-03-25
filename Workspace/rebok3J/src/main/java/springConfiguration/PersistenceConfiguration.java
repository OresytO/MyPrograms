package springConfiguration;

import java.util.Properties;

import javax.sql.DataSource;

import org.flywaydb.core.Flyway;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.EclipseLinkJpaDialect;
import org.springframework.orm.jpa.vendor.EclipseLinkJpaVendorAdapter;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.rebok3J.model.impl.User;
import com.rebok3J.model.impl.Visit;
import com.rebok3J.model.impl.Visitor;

/**
 * Created by OrestO on 3/12/2015.
 */
@Configuration
@EnableJpaRepositories(basePackageClasses = { User.class, Visit.class, Visitor.class })
@EnableTransactionManagement
public class PersistenceConfiguration
{

  // TODO: why don't work?
  public static final String JPA_PROPERTIES = "jpa.properties";
  public static final String PACKAGE_TO_SCAN = "com.rebok3J.model";

  @Bean(initMethod = "migrate")
  public Flyway flyway() {
    Flyway flyway = new Flyway();
    flyway.setBaselineOnMigrate(true);
    flyway.setLocations("classpath:db/migration");
    flyway.setDataSource(dataSource());
    return flyway;
  }

  @Bean
  public DataSource dataSource() {
    DriverManagerDataSource dataSource = new DriverManagerDataSource();

    dataSource.setDriverClassName("org.postgresql.Driver");
    dataSource.setUrl("jdbc:postgresql://localhost:5432/rebok3J_DB");
    dataSource.setUsername("postgres");
    dataSource.setPassword("njvfmkcd@2410@");

    return dataSource;
  }

  @Bean @DependsOn("flyway")
  public LocalContainerEntityManagerFactoryBean entityManagerFactory() {
    LocalContainerEntityManagerFactoryBean entityManagerFactoryBean = new LocalContainerEntityManagerFactoryBean();
    entityManagerFactoryBean.setDataSource(dataSource());

    entityManagerFactoryBean.setJpaVendorAdapter(new EclipseLinkJpaVendorAdapter());
    entityManagerFactoryBean.setPackagesToScan(PACKAGE_TO_SCAN);
    entityManagerFactoryBean.setJpaDialect(new EclipseLinkJpaDialect());
    entityManagerFactoryBean.setJpaVendorAdapter(new EclipseLinkJpaVendorAdapter());
    Properties properties = new Properties();
    properties.setProperty("eclipselink.weaving", "static");
    entityManagerFactoryBean.setJpaProperties(properties);

    return entityManagerFactoryBean;
  }

  @Bean
  public JpaTransactionManager transactionManager()
  {
    JpaTransactionManager transactionManager = new JpaTransactionManager();
    transactionManager.setEntityManagerFactory(entityManagerFactory().getObject());
    return transactionManager;
  }

}