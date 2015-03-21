package springConfiguration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;

/**
 * Created by OrestO on 3/12/2015.
 */
@Configuration
@EnableWebSecurity
public class SpringSecurityConfiguration extends WebSecurityConfigurerAdapter
{

  @Autowired
  AuthenticationProvider customAuthenticationProvider;

  @Autowired
  UserDetailsService userDetailsService;

  @Override
  protected void configure(HttpSecurity http) throws Exception
  {

    http
        .authorizeRequests()
        .antMatchers("/resources/**").permitAll()
        .antMatchers("/security/**").permitAll()
        .antMatchers("/admin/**").hasAuthority("admin")
        .antMatchers("/director/**").hasAuthority("director")
        .antMatchers("/manager/**").hasAuthority("manager")
        .and().formLogin()
          .loginPage("/login")
          .failureUrl("/failure")
          .defaultSuccessUrl("/home")
          .loginProcessingUrl("/login")
          .usernameParameter("username")
          .passwordParameter("password")
          .permitAll()
        .and().exceptionHandling()
          .accessDeniedPage("/denied")
        .and().logout()
        .logoutUrl("/logout")
          .logoutSuccessUrl("/login")
          .invalidateHttpSession(true)
          .permitAll();
  }

  @Override
  protected void configure(AuthenticationManagerBuilder auth) throws Exception
  {
    auth.authenticationProvider(customAuthenticationProvider).userDetailsService(userDetailsService);
  }
}
