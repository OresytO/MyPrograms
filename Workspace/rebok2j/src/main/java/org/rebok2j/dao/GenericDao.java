package org.rebok2j.dao;

import org.rebok2j.domain.Domain;

import java.util.List;
import java.util.Map;

public interface GenericDao<T> {

    void persist(T entity);

    T merge(T entity);

    void remove(T entity);

    T findById(Long id);

    List<T> getResultList();

    List<T> getResultListFromNamedQuery(String namedQueryName, Map<String, String> paramMap);

    T getSingleResultFromNamedQuery(String namedQueryName, Map<String, String> paramMap);
}
