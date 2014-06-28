package org.rebok2j.service.impl;

import org.rebok2j.dao.UserDao;
import org.rebok2j.domain.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import static org.rebok2j.utils.DomainConstants.USER;

@Service
@Transactional(readOnly = true)
public class CustomUserDetailsService implements UserDetailsService {

  @Autowired
  private UserDao userDao;

  @Override
  public UserDetails loadUserByUsername(String userNickname) throws UsernameNotFoundException {
    try {
      Map<String, String> map = new HashMap<>();
      map.put(USER.NICKNAME, userNickname);
      org.rebok2j.domain.User domainUser = userDao.getSingleResultFromNamedQuery(USER.FIND_BY_NICKNAME, map);
      boolean accountNonExpired = true;
      boolean credentialsNonExpired = true;
      boolean accountNonLocked = true;

      return new User(domainUser.getUserName(), domainUser.getPassword().toLowerCase(), domainUser.getEnabled(), accountNonExpired,
        credentialsNonExpired, accountNonLocked, getGrantedAuthorities(domainUser.getRoles()));
    } catch (Exception e) {
      throw new RuntimeException(e);
    }
  }

  private Set<GrantedAuthority> getGrantedAuthorities(Set<Role> roles) {
    Set<GrantedAuthority> authorities = new HashSet<GrantedAuthority>();
    for (Role role : roles) {
      authorities.add(new SimpleGrantedAuthority(role.getRoleName()));
    }
    return authorities;
  }
}
