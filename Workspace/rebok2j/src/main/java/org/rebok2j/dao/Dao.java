package org.rebok2j.dao;

import java.util.List;
import java.util.Map;

public interface Dao<T> {

    void persist(T entity);

    T merge(T entity);

    void remove(T entity);

    T findById(Long id);

    T getSingleResultFromNamedQuery(String queryName, Map<String, String> paramMap);

    List<T> getResultListFromNamedQuery(String queryName, Map<String, String> paramMap);

}
