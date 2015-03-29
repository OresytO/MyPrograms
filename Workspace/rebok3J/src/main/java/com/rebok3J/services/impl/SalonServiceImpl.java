package com.rebok3J.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rebok3J.dao.SalonDao;
import com.rebok3J.model.impl.Salon;
import com.rebok3J.services.SalonService;

/**
 * @author OrestO
 * @since 3/29/2015
 */
@Service
public class SalonServiceImpl implements SalonService
{

  @Autowired
  private SalonDao salonDao;

  @Override
  public Salon findById(Long id)
  {
    return salonDao.findById(id);
  }

  @Override
  public List<Salon> loadAll() throws InstantiationException, IllegalAccessException
  {
    return salonDao.loadAll();
  }
}
