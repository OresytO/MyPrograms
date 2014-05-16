package org.rebok2j.dao;

public interface Dao<T> {

    void persist(T entity);

    T merge(T entity);

    void remove(T entity);

    T findById(Integer id);

}
