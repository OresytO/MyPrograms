package org.rebok2j.dao.impl;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.rebok2j.dao.IdTypeDao;
import org.springframework.stereotype.Repository;

@Repository
public class IdTypeDaoImpl implements IdTypeDao {

    @PersistenceContext
    // (name = "primary")
    private EntityManager entityManager;

}
