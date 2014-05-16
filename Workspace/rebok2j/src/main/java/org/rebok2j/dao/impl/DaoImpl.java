package org.rebok2j.dao.impl;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

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
    public T findById(Integer id) {
        return (T) entityManager.find(Object.class, id);
    }
}
