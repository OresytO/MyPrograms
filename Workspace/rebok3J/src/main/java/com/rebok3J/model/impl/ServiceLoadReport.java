package com.rebok3J.model.impl;

import java.util.Date;

import javax.annotation.Nonnull;
import javax.persistence.*;

import com.rebok3J.model.ModelObjectImpl;
import com.rebok3J.model.ServiceLoadReportQueryHolder;

/**
 *
 *
 * @author OrestO
 * @since 3/12/2015
 */
@Entity
@Table(name = ServiceLoadReport.SERVICE_LOAD_REPORT_TABLE)
@NamedQueries({
    @NamedQuery(name = ServiceLoadReportQueryHolder.FIND_ALL, query = ServiceLoadReportQueryHolder.FIND_ALL_QUERY)
})
public class ServiceLoadReport extends ModelObjectImpl<ServiceLoadReport> implements ServiceLoadReportQueryHolder
{

  private static final long serialVersionUID = 1L;

  public static final String SERVICE_LOAD_REPORT_ENTITY = "ServiceLoadReport";
  public static final String SERVICE_LOAD_REPORT_TABLE = "\"service_load_report\"";

  @Id
  @SequenceGenerator(name = ID_SEQ, sequenceName = ID_SEQ, allocationSize = 1)
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = ID_SEQ)
  @Column(name = ID_COLUMN)
  private Long id;
  public static final String ID_COLUMN = "id";
  public static final String ID_SEQ = "service_load_report_id_seq";

  @Column(name = NAME_COLUMN, nullable = false)
  private String name;
  public static final String NAME_COLUMN = "name";

  @Temporal(TemporalType.TIMESTAMP)
  @Column(name = CREATE_DATE_COLUMN, nullable = false)
  private Date createDate;
  public static final String CREATE_DATE_COLUMN = "create_date";

  @Override
  public Long getId()
  {
    return id;
  }

  public void setId(Long id)
  {
    this.id = id;
  }

  public String getName()
  {
    return name;
  }

  public void setName(String name)
  {
    this.name = name;
  }

  public Date getCreateDate()
  {
    return createDate;
  }

  public void setCreateDate(Date createDate)
  {
    this.createDate = createDate;
  }

  @Override
  public String getFindAllQueryName()
  {
    return FIND_ALL;
  }

  @Override
  public int hashCode()
  {
    return super.hashCode(id);
  }

  @Override
  public boolean equals(Object obj)
  {
    return obj instanceof ServiceLoadReport && super.equals(this, (ServiceLoadReport) obj);
  }

  @Override
  public int compareTo(@Nonnull ServiceLoadReport obj)
  {
    return this.getName().compareTo(obj.getName());
  }

  @PrePersist
  public void createdTimestamp()
  {
    createDate = new Date();
  }
}
