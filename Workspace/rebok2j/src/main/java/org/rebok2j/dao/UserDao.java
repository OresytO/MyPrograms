package org.rebok2j.dao;

import java.util.List;

import org.rebok2j.domain.User;

public interface UserDao {

    User findByNickname(String nickname);

    List<User> findAllUsers();

    User findUserById(Long id);

}
