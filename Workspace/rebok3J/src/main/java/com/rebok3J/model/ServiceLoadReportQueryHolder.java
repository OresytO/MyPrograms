package com.rebok3J.model;

import static com.rebok3J.model.impl.ServiceLoadReport.SERVICE_LOAD_REPORT_ENTITY;

/**
 *
 *
 * @author OrestO
 * @since 3/13/2015
 */
public interface ServiceLoadReportQueryHolder extends CommonQueryHolder
{
  String FIND_ALL = SERVICE_LOAD_REPORT_ENTITY + CommonQueryHolder.FIND_ALL;
  String FIND_ALL_QUERY = "select e from " + SERVICE_LOAD_REPORT_ENTITY + " e";

  @Override
  String getFindAllQueryName();
}
