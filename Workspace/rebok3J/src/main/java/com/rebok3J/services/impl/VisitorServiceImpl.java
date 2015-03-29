package com.rebok3J.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rebok3J.dao.VisitorDao;
import com.rebok3J.model.impl.Visitor;
import com.rebok3J.services.VisitorService;

/**
 * @author OrestO
 * @since 3/29/2015
 */
@Service
public class VisitorServiceImpl implements VisitorService
{

  @Autowired
  private VisitorDao visitorDao;

  @Override
  public Visitor findById(Long id)
  {
    return visitorDao.findById(id);
  }

  @Override
  public List<Visitor> loadAll() throws InstantiationException, IllegalAccessException
  {
    return visitorDao.loadAll();
  }
}
