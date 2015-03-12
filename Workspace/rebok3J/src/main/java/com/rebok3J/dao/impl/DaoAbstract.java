package com.rebok3J.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import com.rebok3J.dao.Dao;
import com.rebok3J.dao.DaoNamedQueries;

/**
 * Created by OrestO on 3/12/2015.
 */
public class DaoAbstract<T> implements Dao<T>
{

  @PersistenceContext
  protected EntityManager entityManager;

  private Class<T> type;

  @Override
  public T findById(Long id)
  {
    return entityManager.find(type, id);
  }

  @Override
  public List<T> loadAll() throws IllegalAccessException, InstantiationException
  {
    if (!(type.newInstance() instanceof DaoNamedQueries))
    {
      throw new IllegalArgumentException("Unsupported operation!!! DAO no implements " + DaoNamedQueries.class);
    }
    TypedQuery<T> query = entityManager.createNamedQuery(((DaoNamedQueries) type.newInstance()).getFindAll(), type);
    return query.getResultList();
  }

}
