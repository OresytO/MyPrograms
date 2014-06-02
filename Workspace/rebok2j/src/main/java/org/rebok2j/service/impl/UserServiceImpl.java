package org.rebok2j.service.impl;

import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.rebok2j.dao.UserDao;
import org.rebok2j.domain.User;
import org.rebok2j.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired
    UserDao userDao;

    @Override
    public List<User> getAllUsers() {
        return userDao.findAllUsers();
    }

    @Override
    public User findUserById(Long id) {
        return userDao.findUserById(id);
    }

    @Override
    public Map<User, Boolean> getAllUsersMap() {
        Map<User, Boolean> map = new TreeMap<>();
        for (User user : getAllUsers()) {
            map.put(user, false);
        }
        return map;
    }
}
