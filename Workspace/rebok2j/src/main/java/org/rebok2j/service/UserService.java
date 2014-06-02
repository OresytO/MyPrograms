package org.rebok2j.service;

import java.util.List;
import java.util.Map;

import org.rebok2j.domain.User;

public interface UserService {

    List<User> getAllUsers();

    User findUserById(Long id);

    Map<User, Boolean> getAllUsersMap();

}
