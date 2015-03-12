package com.rebok3J.dao.impl;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.springframework.stereotype.Repository;

import com.rebok3J.dao.Dao;
import com.rebok3J.dao.DaoNamedQueries;

/**
 * Created by OrestO on 3/12/2015.
 */
@Repository
//TODO: Copy named query work from @see org.rebok2j.utils.DomainConstants
public class DaoAbstract<T> implements Dao<T>
{

  public static final String PERSISTENCE_UNIT_NAME = "primary";
  @PersistenceContext(name = PERSISTENCE_UNIT_NAME)
  protected EntityManager entityManager;

  private Class<T> clazz;

  // TODO: Check if this check is needed
  public DaoAbstract()
  {
    Type t = getClass().getGenericSuperclass();
    if (t instanceof ParameterizedType)
    {
      ParameterizedType pt = (ParameterizedType) t;
      clazz = (Class) pt.getActualTypeArguments()[0];
    }
    else if (t instanceof Class)
    {
      clazz = (Class) t;
    }
    else
    {
      throw new IllegalStateException("ERROR!!! :)");
    }
  }

  @Override
  public T findById(Long id)
  {
    return entityManager.find(clazz, id);
  }

  @Override
  public List<T> loadAll() throws IllegalAccessException, InstantiationException
  {
    if (clazz == null || !(clazz.newInstance() instanceof DaoNamedQueries))
    {
      throw new IllegalArgumentException("Unsupported operation!!! DAO no implements " + DaoNamedQueries.class);
    }
    TypedQuery<T> query = entityManager.createNamedQuery(((DaoNamedQueries) clazz.newInstance()).getFindAll(), clazz);
    return query.getResultList();
  }

}
