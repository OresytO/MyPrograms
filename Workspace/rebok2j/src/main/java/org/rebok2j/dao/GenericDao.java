package org.rebok2j.dao;

import java.util.List;
import java.util.Map;

/**
 * Created by OrestO
 * on 6/28/2014.
 */
/*It is global Dao interface based on generic types*/
public interface GenericDao<T> {

  void persist(T entity);

  T merge(T entity);

  void remove(T entity);

  T findById(Long id);

  List<T> getResultList();

  List<T> getResultListFromNamedQuery(String namedQueryName, Map<String, String> paramMap);

  T getSingleResultFromNamedQuery(String namedQueryName, Map<String, String> paramMap);
}
