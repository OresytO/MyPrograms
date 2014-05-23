package org.rebok2j.dao;

import org.rebok2j.domain.User;

public interface UserDao {

    User findByNickname(String nickname);

}
