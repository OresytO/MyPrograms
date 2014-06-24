package org.rebok2j.dao;

import java.util.List;
import java.util.Map;

public interface Dao<T> {

    void persist(T entity);

    T merge(T entity);

    void remove(T entity);

    T findById(Long id);

    T getSingleResult();

    List<T> getResultList();

    List<T> getResultListFromNamedQuery(String namedQueryName, Map<String, String> paramMap);

    T getSingleResultFromNamedQuery(String namedQueryName, Map<String, String> paramMap);
}
