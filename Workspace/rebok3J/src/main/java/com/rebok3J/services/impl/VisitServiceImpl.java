package com.rebok3J.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rebok3J.dao.VisitDao;
import com.rebok3J.model.impl.Visit;
import com.rebok3J.services.VisitService;

/**
 * @author OrestO
 * @since 3/29/2015
 */
@Service
public class VisitServiceImpl implements VisitService
{

  @Autowired
  private VisitDao visitDao;

  @Override
  public Visit findById(Long id)
  {
    return visitDao.findById(id);
  }

  @Override
  public List<Visit> loadAll() throws InstantiationException, IllegalAccessException
  {
    return visitDao.loadAll();
  }

  @Override
  public void save(Visit entity)
  {
    visitDao.save(entity);
  }

  @Override
  public Visit update(Visit entity)
  {
    return visitDao.update(entity);
  }
}
