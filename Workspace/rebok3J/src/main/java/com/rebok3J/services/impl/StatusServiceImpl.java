package com.rebok3J.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rebok3J.dao.StatusDao;
import com.rebok3J.model.impl.Status;
import com.rebok3J.services.StatusService;

/**
 * @author OrestO
 * @since 3/29/2015
 */
@Service
public class StatusServiceImpl implements StatusService
{

  @Autowired
  private StatusDao statusDao;

  @Override
  public Status findById(Long id)
  {
    return statusDao.findById(id);
  }

  @Override
  public List<Status> loadAll() throws InstantiationException, IllegalAccessException
  {
    return statusDao.loadAll();
  }

  @Override
  public void save(Status entity)
  {
    statusDao.save(entity);
  }

  @Override
  public Status update(Status entity)
  {
    return statusDao.update(entity);
  }
}
