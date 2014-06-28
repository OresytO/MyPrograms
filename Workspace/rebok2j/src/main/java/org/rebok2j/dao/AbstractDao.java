package org.rebok2j.dao;

import org.apache.log4j.Logger;
import org.rebok2j.domain.Domain;
import org.rebok2j.utils.DomainConstants;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;

@Repository
public abstract class AbstractDao<T> implements GenericDao<T> {
    private static Logger log = Logger.getLogger(AbstractDao.class);
    public static final String PERSISTENCE_UNIT_NAME = "primary";
    @PersistenceContext
    // (name = "primary")
    private EntityManager entityManager;

    private Class<T> clazz;

    public AbstractDao() {
        Type t = getClass().getGenericSuperclass();
        ParameterizedType pt = (ParameterizedType) t;
        clazz = (Class) pt.getActualTypeArguments()[0];
    }

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
    public List<T> getResultList() {
        if (clazz == null) {
            System.out.println("---------------- NUL ----------------------");
            log.debug("---------------- NUL ----------------------");
        }
        //System.out.println(clazz.getSimpleName() + DomainConstants.DELIMITER_CHARACTER + DomainConstants.FIND_ALL_G);
        //log.debug("+++++++++++++++++++++++++++++++++" + clazz.getSimpleName() + DomainConstants.DELIMITER_CHARACTER + DomainConstants.FIND_ALL_G);
        Query query = entityManager.createNamedQuery(clazz.getSimpleName() + DomainConstants.DELIMITER_CHARACTER + DomainConstants.FIND_ALL_G);
        return (List<T>) query.getResultList();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<T> getResultListFromNamedQuery(String namedQueryName, Map<String, String> paramMap) {
        Query query = entityManager.createNamedQuery(namedQueryName);
        if (paramMap != null) {
            for (String key : paramMap.keySet()) {
                query.setParameter(key, paramMap.get(key));
            }
        }
        return (List<T>) query.getResultList();
    }

    @SuppressWarnings("unchecked")
    @Override
    public T getSingleResultFromNamedQuery(String namedQueryName, Map<String, String> paramMap) {
        Query query = entityManager.createNamedQuery(namedQueryName);
        if (paramMap != null) {
            for (String key : paramMap.keySet()) {
                query.setParameter(key, paramMap.get(key));
            }
        }
        return (T) query.getSingleResult();
    }
}
