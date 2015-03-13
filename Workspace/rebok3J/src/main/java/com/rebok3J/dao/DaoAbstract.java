package com.rebok3J.dao;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import com.rebok3J.model.CommonQueryHolder;

/**
 * Created by OrestO on 3/12/2015.
 */
// TODO: Copy named query work from @see org.rebok2j.utils.DomainConstants
public class DaoAbstract<T> implements Dao<T>
{

  public static final String PERSISTENCE_UNIT_NAME = "primary";
  @PersistenceContext(name = PERSISTENCE_UNIT_NAME)
  protected EntityManager entityManager;

  private Class<T> clazz;

  public DaoAbstract()
  {
    Type t = getClass().getGenericSuperclass();
    ParameterizedType pt = (ParameterizedType) t;
    clazz = (Class) pt.getActualTypeArguments()[0];
  }

  @Override
  public T findById(Long id)
  {
    return entityManager.find(clazz, id);
  }

  @Override
  public List<T> loadAll() throws IllegalAccessException, InstantiationException
  {
    if (clazz == null || !(clazz.newInstance() instanceof CommonQueryHolder))
    {
      throw new IllegalArgumentException("Unsupported operation!!! DAO no implements " + CommonQueryHolder.class);
    }
    TypedQuery<T> query = entityManager.createNamedQuery(((CommonQueryHolder) clazz.newInstance()).getFindAll(), clazz);
    return query.getResultList();
  }

  @Override
  public List<T> getResultListFromNamedQuery(String namedQueryName, Map<String, String> paramMap)
  {
    TypedQuery<T> query = entityManager.createNamedQuery(namedQueryName, clazz);
    if (paramMap != null)
    {
      for (String key : paramMap.keySet())
      {
        query.setParameter(key, paramMap.get(key));
      }
    }
    return query.getResultList();
  }

  @Override
  public T getSingleResultFromNamedQuery(String namedQueryName, Map<String, String> paramMap)
  {
    TypedQuery<T> query = entityManager.createNamedQuery(namedQueryName, clazz);
    if (paramMap != null)
    {
      for (String key : paramMap.keySet())
      {
        query.setParameter(key, paramMap.get(key));
      }
    }
    return query.getSingleResult();
  }
}
