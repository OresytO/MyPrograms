package org.rebok2j.service.impl;

import org.rebok2j.utils.Components;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Component;

import java.util.Collection;

@Component(Components.CUSTOM_AUTHENTICATION_PROVIDER)
public class CustomAuthenticationProvider implements AuthenticationProvider {

  @Autowired
  private UserDetailsService userService;

  @Override
  public Authentication authenticate(Authentication authentication) throws AuthenticationException {
    String username = authentication.getName();
    String password = (String) authentication.getCredentials();
    UserDetails user = userService.loadUserByUsername(username);
    if (user == null) {
      throw new BadCredentialsException("Username not found.");
    }

    if (!password.equals(user.getPassword())) {
      throw new BadCredentialsException("Wrong password.");
    }

    Collection<? extends GrantedAuthority> authorities = user.getAuthorities();

    return new UsernamePasswordAuthenticationToken(username, password, authorities);
  }

  @Override
  public boolean supports(Class<?> arg0) {
    return true;
  }
}
