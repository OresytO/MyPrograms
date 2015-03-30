package com.rebok3J.dao;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;

import org.springframework.transaction.annotation.Transactional;

import com.rebok3J.model.CommonQueryHolder;

/**
 *
 *
 * @author OrestO
 * @since 3/12/2015
 */
// TODO: Copy named query work from @see org.rebok2j.utils.DomainConstants
public class DaoAbstract<T> implements Dao<T>
{

  public static final String PERSISTENCE_UNIT_NAME = "primary";
  @PersistenceContext(name = PERSISTENCE_UNIT_NAME)
  protected EntityManager entityManager;

  private Class<T> clazz;

  @SuppressWarnings("unchecked")
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
      throw new IllegalArgumentException("Unsupported operation!!! DAO do not implements " + CommonQueryHolder.class);
    }
    TypedQuery<T> query = entityManager.createNamedQuery(((CommonQueryHolder) clazz.newInstance()).getFindAllQueryName(), clazz);
    return query.getResultList();
  }

  @Override
  @Transactional
  public void save(T entity)
  {
    entityManager.persist(entity);
  }

  @Override
  @Transactional
  public T update(T entity)
  {
    return entityManager.merge(entity);
  }

  @Override
  public List<T> getResultListFromNamedQuery(String namedQueryName, List<Param> params)
  {
    TypedQuery<T> query = fulfillQuery(namedQueryName, params);
    return query.getResultList();
  }

  @Override
  public T getSingleResultFromNamedQuery(String namedQueryName, List<Param> params)
  {
    TypedQuery<T> query = fulfillQuery(namedQueryName, params);
    return query.getSingleResult();
  }

  private TypedQuery<T> fulfillQuery(String namedQueryName, List<Param> params)
  {
    TypedQuery<T> query = entityManager.createNamedQuery(namedQueryName, clazz);
    if (params != null)
    {
      for (Param param : params)
      {
        query.setParameter(param.getName(), param.getValue());
      }
    }
    return query;
  }

  @Override
  public List<Object> getResultListFromNamedNativeQuery(String namedNativeQueryName, List<Param> params)
  {
    Query query = fulfillNativeQuery(namedNativeQueryName, params);
    return query.getResultList();
  }

  @Override
  public Object getSingleResultFromNamedNativeQuery(String namedNativeQueryName, List<Param> params)
  {
    Query query = fulfillNativeQuery(namedNativeQueryName, params);
    return query.getSingleResult();
  }

  private Query fulfillNativeQuery(String namedQueryName, List<Param> params)
  {
    Query query = entityManager.createNamedQuery(namedQueryName);
    if (params != null)
    {
      for (Param param : params)
      {
        query.setParameter(param.getName(), param.getValue());
      }
    }
    return query;
  }

}
