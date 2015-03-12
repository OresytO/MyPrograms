package com.rebok3J.model;

import java.util.Date;

/**
 * Created by OrestO
 * on 3/12/2015.
 */
public interface Visit {
  long getId();

  void setId(long id);

  Visitor getVisitor();

  void setVisitorId(Visitor visitorId);

  Date getCreateDate();

  void setCreateDate(Date dateOfVisit);
}
