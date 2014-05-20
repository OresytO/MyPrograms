package org.rebok2j.dao.impl;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.rebok2j.dao.AbstractDao;
import org.rebok2j.dao.AutorizationDao;
import org.rebok2j.domain.Autorization;
import org.springframework.stereotype.Repository;

@Repository
public class AutorizationDaoImpl extends AbstractDao implements AutorizationDao {

    @PersistenceContext
    // (name = "primary")
    private EntityManager entityManager;

    @Override
    public void persist(Autorization autorization) {
        entityManager.persist(autorization);
    }

    @Override
    public Autorization merge(Autorization autorization) {
        return entityManager.merge(autorization);
    }

    @Override
    public void remove(Autorization autorization) {
        entityManager.remove(autorization);
    }

    @Override
    public Autorization findById(Long id) {
        return entityManager.find(Autorization.class, id);
    }

}
