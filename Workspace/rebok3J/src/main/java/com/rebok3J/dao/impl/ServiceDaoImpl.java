package com.rebok3J.dao.impl;

import static com.rebok3J.model.ServiceQueryHolder.GET_ALL_SERVICES_FOR_SELECT;

import java.util.LinkedList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.rebok3J.dao.DaoAbstract;
import com.rebok3J.dao.Param;
import com.rebok3J.dao.ServiceDao;
import com.rebok3J.model.impl.Service;
import com.rebok3J.web.forms.elements.SelectDTO;

/**
 *
 *
 * @author OrestO
 * @since 3/12/2015
 */
@Repository
public class ServiceDaoImpl extends DaoAbstract<Service> implements ServiceDao
{
  @Override
  public List<SelectDTO> getAllServicesForSelect()
  {
    List<SelectDTO> result = new LinkedList<>();

    List<Object> list = getResultListFromNamedNativeQuery(GET_ALL_SERVICES_FOR_SELECT, Param.get());

    for (Object object : list)
    {
      Object[] objects = (Object[]) object;
      result.add(new SelectDTO(objects[0].toString(), objects[1].toString()));
    }

    return result;
  }
}
