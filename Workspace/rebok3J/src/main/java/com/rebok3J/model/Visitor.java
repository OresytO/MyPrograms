package com.rebok3J.model;

import java.util.Date;
import java.util.List;

/**
 * Created by OrestO on 3/12/2015.
 */
public interface Visitor
{
  long getId();

  void setId(long id);

  String getName();

  void setName(String name);

  Date getCreateDate();

  void setCreateDate(Date createDate);

  List<Visit> getVisits();

  void setVisits(List<Visit> visits);
}
