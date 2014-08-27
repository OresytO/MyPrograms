package org.rebok2j.configuration;

import org.rebok2j.utils.Components;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.servlet.configuration.EnableWebMvcSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.filter.DelegatingFilterProxy;

/**
 * Created by OrestO
 * on 6/28/2014.
 */

@Configuration
@EnableWebSecurity
@EnableWebMvcSecurity
public class SpringSecurityConfiguration extends WebSecurityConfigurerAdapter {

  @Autowired
  @Qualifier(Components.CUSTOM_AUTHENTICATION_PROVIDER)
  AuthenticationProvider authenticationProvider;

  @Autowired
  @Qualifier(Components.CUSTOM_USER_DETAILS_SERVICE)
  UserDetailsService userDetailsService;

  @Override
  public void configure(WebSecurity web) throws Exception {
    //Spring Security ignores request to static resources such as CSS or JS files.
    web.ignoring().antMatchers("/resources");
  }

/*  @Override
  protected void configure(AuthenticationManagerBuilder auth)
    throws Exception {
    auth.inMemoryAuthentication().withUser("user").password("password").roles("USER");
  }*/

  @Override
  protected void configure(HttpSecurity http) throws Exception {

    http.authorizeRequests()
      .and().formLogin().loginPage("/login").failureUrl("/login/failure").defaultSuccessUrl("/")
      .and().exceptionHandling().accessDeniedPage("/denied")
      .and().logout().invalidateHttpSession(true).logoutSuccessUrl("/").logoutUrl("/logout")
      .and().authenticationProvider(authenticationProvider).userDetailsService(userDetailsService);
    http.addFilter(new DelegatingFilterProxy());
  }
}
