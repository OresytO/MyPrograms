package springConfiguration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.rebok3J.model.impl.Role;

/**
 *
 *
 * @author OrestO
 * @since 3/12/2015
 */
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled=true)
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
        .antMatchers("/service/**").hasRole(Role.ADMIN)
        .antMatchers("/visitor/**").hasRole(Role.DIRECTOR)
        .antMatchers("/visit/**").hasRole(Role.MANAGER)
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
          .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
          .logoutSuccessUrl("/home")
          .invalidateHttpSession(true)
          .permitAll();
  }

  @Override
  protected void configure(AuthenticationManagerBuilder auth) throws Exception
  {
    auth.authenticationProvider(customAuthenticationProvider).userDetailsService(userDetailsService);
  }

  @Bean
  @Override
  public AuthenticationManager authenticationManagerBean() throws Exception
  {
    return super.authenticationManagerBean();
  }

}
