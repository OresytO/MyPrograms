package org.rebok2j.dao.impl;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.rebok2j.dao.AbstractDao;
import org.rebok2j.dao.Dao;
import org.rebok2j.utils.DaoConstants;
import org.springframework.stereotype.Repository;

@Repository
public class DaoImpl<T> extends AbstractDao implements Dao<T> {

    @PersistenceContext
    // (name = "primary")
    private EntityManager entityManager;

    private Class<T> clazz;

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
    public T getSingleResult() {
        Query query = entityManager.createNamedQuery(clazz.getSimpleName() + "." + DaoConstants.GET_SINGLE_RESULT);
        return (T) query.getSingleResult();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<T> getResultList() {
        Query query = entityManager.createNamedQuery(clazz.getSimpleName() + "." + DaoConstants.GET_RESULT_LIST);
        return (List<T>) query.getResultList();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<T> getResultListFromNamedQuery(String namedQueryName, Map<String, String> paramMap) {
        Query query = entityManager.createNamedQuery(clazz.getSimpleName() + "." + namedQueryName);
        if(paramMap != null){
            for(String key : paramMap.keySet()){
                query.setParameter(key, paramMap.get(key));
            }
        }
        return (List<T>) query.getResultList();
    }

    @SuppressWarnings("unchecked")
    @Override
    public T getSingleResultFromNamedQuery(String namedQueryName, Map<String, String> paramMap) {
        Query query = entityManager.createNamedQuery(clazz.getSimpleName() + "." + namedQueryName);
        if(paramMap != null){
            for(String key : paramMap.keySet()){
                query.setParameter(key, paramMap.get(key));
            }
        }
        return (T) query.getSingleResult();
    }
}
