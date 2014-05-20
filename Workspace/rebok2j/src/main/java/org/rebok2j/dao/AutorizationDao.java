package org.rebok2j.dao;

import org.rebok2j.domain.Autorization;

public interface AutorizationDao {

    void persist(Autorization autorization);

    Autorization merge(Autorization autorization);

    void remove(Autorization autorization);

    Autorization findById(Long id);

}
