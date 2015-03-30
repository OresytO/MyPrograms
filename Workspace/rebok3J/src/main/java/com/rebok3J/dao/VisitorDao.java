package com.rebok3J.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.rebok3J.model.impl.Visitor;
import com.rebok3J.web.forms.elements.SelectDTO;

/**
 *
 *
 * @author OrestO
 * @since 3/13/2015
 */

@Repository
public interface VisitorDao extends Dao<Visitor>
{
  List<SelectDTO> getAllServicesForSelect();
}
