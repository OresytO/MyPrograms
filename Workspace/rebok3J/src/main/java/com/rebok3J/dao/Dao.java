package com.rebok3J.dao;

import java.util.List;

/**
 *
 *
 * @author OrestO
 * @since 3/12/2015
 */
public interface Dao<T>
{
  T findById(Long id);

  List<T> loadAll() throws IllegalAccessException, InstantiationException;

  void save(T entity);

  T update(T entity);

  List<T> getResultListFromNamedQuery(String namedQueryName, List<Param> params);

  // List<T> getResultListFromNamedQuery(String namedQueryName, Map<String,
  // String> paramMap);

  // T getSingleResultFromNamedQuery(String namedQueryName, Map<String, String>
  // paramMap);

  T getSingleResultFromNamedQuery(String namedQueryName, List<Param> params);

  List<Object> getResultListFromNamedNativeQuery(String namedNativeQueryName, List<Param> params);

  Object getSingleResultFromNamedNativeQuery(String namedNativeQueryName, List<Param> params);
}
