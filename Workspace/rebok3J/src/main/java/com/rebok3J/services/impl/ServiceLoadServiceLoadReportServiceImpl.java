package com.rebok3J.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rebok3J.dao.ServiceLoadReportDao;
import com.rebok3J.model.impl.ServiceLoadReport;
import com.rebok3J.services.ServiceLoadReportService;

/**
 * @author OrestO
 * @since 3/29/2015
 */
@Service
public class ServiceLoadServiceLoadReportServiceImpl implements ServiceLoadReportService
{

  @Autowired
  private ServiceLoadReportDao serviceLoadReportDao;

  @Override
  public ServiceLoadReport findById(Long id)
  {
    return serviceLoadReportDao.findById(id);
  }

  @Override
  public List<ServiceLoadReport> loadAll() throws InstantiationException, IllegalAccessException
  {
    return serviceLoadReportDao.loadAll();
  }

  @Override
  public void save(ServiceLoadReport entity)
  {
    serviceLoadReportDao.save(entity);
  }

  @Override
  public ServiceLoadReport update(ServiceLoadReport entity)
  {
    return serviceLoadReportDao.update(entity);
  }
}
