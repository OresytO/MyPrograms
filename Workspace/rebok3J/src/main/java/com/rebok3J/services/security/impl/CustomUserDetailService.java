package com.rebok3J.services.security.impl;

import static com.rebok3J.model.UserQueryHolder.FIND_BY_NICKNAME;
import static com.rebok3J.model.UserQueryHolder.NICKNAME;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.rebok3J.dao.Param;
import com.rebok3J.dao.UserDao;
import com.rebok3J.model.impl.Role;

/**
 *
 *
 * @author OrestO
 * @since 3/13/2015
 */

@Service
@Transactional(readOnly = true)
public class CustomUserDetailService implements UserDetailsService
{

  @Autowired
  private UserDao userDao;

  @Override
  public UserDetails loadUserByUsername(String userNickname) throws UsernameNotFoundException
  {
    try
    {
      com.rebok3J.model.impl.User domainUser = userDao.getSingleResultFromNamedQuery(FIND_BY_NICKNAME, Param.get(NICKNAME, userNickname));
      boolean accountNonExpired = true;
      boolean credentialsNonExpired = true;
      boolean accountNonLocked = true;

      return new User(domainUser.getUserName(), domainUser.getPassword().toLowerCase(), domainUser.getEnabled(), accountNonExpired, credentialsNonExpired, accountNonLocked,
          getGrantedAuthorities(domainUser.getRoles()));
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
  }

  private Set<GrantedAuthority> getGrantedAuthorities(Collection<Role> roles)
  {
    Set<GrantedAuthority> authorities = new HashSet<>();
    for (Role role : roles)
    {
      authorities.add(new SimpleGrantedAuthority(role.getRoleName()));
    }
    return authorities;
  }
}