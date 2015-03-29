package com.rebok3J.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.rebok3J.dao.ServiceDao;
import com.rebok3J.model.impl.Service;
import com.rebok3J.services.ServiceService;

/**
 * @author OrestO
 * @since 3/29/2015
 */
@org.springframework.stereotype.Service
public class ServiceServiceImpl implements ServiceService
{

  @Autowired
  private ServiceDao serviceDao;

  @Override
  public Service findById(Long id)
  {
    return serviceDao.findById(id);
  }

  @Override
  public List<Service> loadAll() throws InstantiationException, IllegalAccessException
  {
    return serviceDao.loadAll();
  }
}
