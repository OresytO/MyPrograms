package org.rebok2j.dao.impl;

import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.rebok2j.dao.AbstractDao;
import org.rebok2j.dao.Dao;
import org.springframework.stereotype.Repository;

@Repository
public class DaoImpl<T> extends AbstractDao implements Dao<T> {

    @PersistenceContext
    // (name = "primary")
    private EntityManager entityManager;

    @Override
    public void persist(T entity) {
        entityManager.persist(entity);
    }

    @Override
    public T merge(T entity) {
        return entityManager.merge(entity);
    }

    @Override
    public void remove(T entity) {
        entityManager.remove(entity);
    }

    @SuppressWarnings("unchecked")
    @Override
    public T findById(Long id) {
        return (T) entityManager.find(Object.class, id);
    }

    @SuppressWarnings("unchecked")
    @Override
    public T getSingleResultFromNamedQuery(String queryName, Map<String, String> paramMap) {
        Query query = entityManager.createNamedQuery(queryName);
        if (paramMap != null)
            for (String name : paramMap.keySet()) {
                query.setParameter(name, paramMap.get(name));
            }
        return (T) query.getSingleResult();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<T> getResultListFromNamedQuery(String queryName, Map<String, String> paramMap) {
        Query query = entityManager.createNamedQuery(queryName);
        if (paramMap != null)
            for (String name : paramMap.keySet()) {
                query.setParameter(name, paramMap.get(name));
            }
        return (List<T>) query.getResultList();
    }
}
