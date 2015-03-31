package com.rebok3J.dao.impl;

import java.util.LinkedList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.rebok3J.dao.DaoAbstract;
import com.rebok3J.dao.Param;
import com.rebok3J.dao.VisitorDao;
import com.rebok3J.model.impl.Visitor;
import com.rebok3J.web.forms.elements.SelectDTO;

/**
 *
 *
 * @author OrestO
 * @since 3/12/2015
 */
@Repository
public class VisitorDaoImpl extends DaoAbstract<Visitor> implements VisitorDao
{
  @Override
  public List<SelectDTO> getAllServicesForSelect()
  {
    List<SelectDTO> result = new LinkedList<>();

    List<Object> list = getResultListFromNamedNativeQuery(Visitor.GET_ALL_VISITORS_FOR_SELECT, Param.get());

    for (Object object : list)
    {
      Object[] objects = (Object[]) object;
      result.add(new SelectDTO((Long) objects[0], objects[1] + " " + objects[2] + " " + objects[3]));
    }

    return result;
  }
}
