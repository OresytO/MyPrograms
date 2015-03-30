package com.rebok3J.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.rebok3J.model.impl.Visitor;
import com.rebok3J.web.forms.elements.SelectDTO;

/**
 * @author OrestO
 * @since 3/29/2015
 */

@Service
public interface VisitorService extends CommonRepoService<Visitor>
{
  List<SelectDTO> getAllVisitorsForSelect();
}
