package org.rebok2j.service.impl;

import org.rebok2j.dao.AutorizationDao;
import org.rebok2j.domain.Autorization;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ServiceImpl implements org.rebok2j.service.Service {

    @Autowired
    AutorizationDao autDao;

    @Override
    public Autorization getAutorazation(Long id) {
        return autDao.findById(id);
    }
}
