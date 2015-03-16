package org.rebok2j.configuration;

import org.rebok2j.utils.Components;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;

/**
 * Created by OrestO
 * on 6/28/2014.
 */

@Configuration
@EnableWebSecurity
//@EnableWebMvcSecurity
public class SpringSecurityConfiguration extends WebSecurityConfigurerAdapter {

  @Autowired
  @Qualifier(Components.CUSTOM_AUTHENTICATION_PROVIDER)
  AuthenticationProvider customAuthenticationProvider;

  @Autowired
  @Qualifier(Components.CUSTOM_USER_DETAILS_SERVICE)
  UserDetailsService userDetailsService;

  @Override
  public void configure(WebSecurity web) throws Exception {
    //Spring Security ignores request to static resources such as CSS or JS files.
    web.ignoring().antMatchers("/resources/**");
  }

/*  @Override
  protected void configure(AuthenticationManagerBuilder auth)
    throws Exception {
    auth.inMemoryAuthentication().withUser("user").password("password").roles("USER");
  }*/

  @Override
  protected void configure(HttpSecurity http) throws Exception {

    http
      .authorizeRequests()
        .antMatchers("/**")
        .hasRole("USER")
        .and()
      .formLogin()
        .loginPage("/login")
        .failureUrl("/login/failure")
        .defaultSuccessUrl("/welcome")
        .permitAll()
        .and()
      .exceptionHandling()
        .accessDeniedPage("/denied")
        .and()
      .logout()
        .logoutUrl("/logout")
        .logoutSuccessUrl("/login")
        .invalidateHttpSession(true)
;
//        .and()
//        .authenticationProvider(customAuthenticationProvider).userDetailsService(userDetailsService)
//      .addFilterBefore(new DelegatingFilterProxy(), BasicAuthenticationFilter.class);

//    http
//        .authorizeRequests()
//        .antMatchers("/**").hasRole("USER")
//        .and()
//        .formLogin();
  }

  @Override
  protected void configure(AuthenticationManagerBuilder auth) throws Exception {
    auth
        .authenticationProvider(customAuthenticationProvider)
        .userDetailsService(userDetailsService);
  }
//
//  @Override
//  protected void configure(HttpSecurity http) throws Exception {
//    http
//        .authorizeRequests()
//        .antMatchers("/app/**").hasRole("ADMIN")
//        .and()
//        .formLogin()
//        .loginPage("/index.jsp")
//        .defaultSuccessUrl("/app/")
//        .failureUrl("/index.jsp")
//        .permitAll()
//        .and()
//        .logout()
//        .logoutSuccessUrl("/index.jsp");
//  }

}
