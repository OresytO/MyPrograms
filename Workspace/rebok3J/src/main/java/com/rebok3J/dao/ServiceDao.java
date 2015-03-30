package com.rebok3J.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.rebok3J.model.impl.Service;
import com.rebok3J.web.forms.elements.SelectDTO;

/**
 *
 *
 * @author OrestO
 * @since 3/13/2015
 */

@Repository
public interface ServiceDao extends Dao<Service>
{
  List<SelectDTO> getAllServicesForSelect();
}
