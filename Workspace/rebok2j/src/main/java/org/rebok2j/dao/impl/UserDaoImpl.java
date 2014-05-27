package org.rebok2j.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.rebok2j.dao.UserDao;
import org.rebok2j.domain.User;
import org.springframework.stereotype.Repository;

@Repository
public class UserDaoImpl implements UserDao {

    @PersistenceContext
    // (name = "primary")
    private EntityManager entityManager;

    @Override
    public User findByNickname(String nickname) {
        return entityManager.createNamedQuery("User.findByNickname", User.class).setParameter("nickname", nickname).getSingleResult();
    }

    @Override
    public List<User> findAllUsers() {
        return entityManager.createNamedQuery("User.findAllUsers", User.class).getResultList();
    }

    @Override
    public User findUserById(Long id) {
        return entityManager.find(User.class, id);
    }
}