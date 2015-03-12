package com.rebok3J.dao.impl;

import org.springframework.stereotype.Repository;

import com.rebok3J.model.User;

/**
 * Created by OrestO on 3/12/2015.
 */

@Repository
public class UserDaoImpl extends DaoAbstract<User>
{
  // private static final Class<User> ENTITY_CLASS = User.class;
  //
  // @Autowired
  // private EntityManager entityManager;
  //
  // @Override
  // public User findById(Long id)
  // {
  // return entityManager.find(ENTITY_CLASS, id);
  // }
  //
  // @Override
  // public List<User> loadAll()
  // {
  // TypedQuery<User> query = entityManager.createNamedQuery(UserImpl.FIND_ALL,
  // ENTITY_CLASS);
  // return query.getResultList();
  // }
}
