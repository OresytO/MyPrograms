package com.rebok3J.services;

import java.util.List;

import com.rebok3J.model.impl.Service;
import com.rebok3J.web.forms.elements.SelectDTO;

/**
 * @author OrestO
 * @since 3/29/2015
 */

@org.springframework.stereotype.Service
public interface ServiceService extends CommonRepoService<Service>
{
  List<SelectDTO> getAllServicesForSelect();
}
