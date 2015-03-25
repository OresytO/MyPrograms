package com.rebok3J.model.impl;

import java.util.Date;

import javax.persistence.*;

import com.rebok3J.model.VisitQueryHolder;

/**
 *
 *
 * @author OrestO
 * @since 3/12/2015
 */
@Entity
@Table(name = Visit.VISIT_TABLE)
@NamedQueries({ @NamedQuery(name = VisitQueryHolder.FIND_ALL, query = VisitQueryHolder.FIND_ALL_QUERY) })
public class Visit implements VisitQueryHolder, Comparable<Visit>
{

  public static final String VISIT_ENTITY = "Visit";
  public static final String VISIT_TABLE = "\"VISIT\"";

  @Id
  @GeneratedValue
  @Column(name = ID_COLUMN)
  private long id;
  public static final String ID_COLUMN = "ID";

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = VISITOR_ID_COLUMN, nullable = false)
  private Visitor visitorId;
  public static final String VISITOR_ID_COLUMN = "VISITOR_ID";

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = SERVICE_ID_COLUMN, nullable = false)
  private Visitor serviceId;
  public static final String SERVICE_ID_COLUMN = "SERVICE_ID";

  @Temporal(TemporalType.TIMESTAMP)
  @Column(name = DATE_OF_VISIT_COLUMN, nullable = false, columnDefinition = "DEFAULT CURRENT_TIMESTAMP")
  private Date dateOfVisit;
  public static final String DATE_OF_VISIT_COLUMN = "DATE_OF_VISIT";

  public long getId()
  {
    return id;
  }

  public void setId(long id)
  {
    this.id = id;
  }

  public Visitor getVisitor()
  {
    return visitorId;
  }

  public void setVisitorId(Visitor visitorId)
  {
    this.visitorId = visitorId;
  }

  public Date getCreateDate()
  {
    return dateOfVisit;
  }

  public void setCreateDate(Date dateOfVisit)
  {
    this.dateOfVisit = dateOfVisit;
  }

  public Visitor getVisitorId()
  {
    return visitorId;
  }

  public Visitor getServiceId()
  {
    return serviceId;
  }

  public void setServiceId(Visitor serviceId)
  {
    this.serviceId = serviceId;
  }

  public Date getDateOfVisit()
  {
    return dateOfVisit;
  }

  public void setDateOfVisit(Date dateOfVisit)
  {
    this.dateOfVisit = dateOfVisit;
  }

  @Override
  public boolean equals(Object o)
  {
    if (this == o)
      return true;
    if (o == null || getClass() != o.getClass())
      return false;

    Visit visit = (Visit) o;

    if (!visitorId.equals(visit.visitorId))
      return false;
    if (!serviceId.equals(visit.serviceId))
      return false;
    return dateOfVisit.equals(visit.dateOfVisit);

  }

  @Override
  public int hashCode()
  {
    int result = visitorId.hashCode();
    result = 31 * result + serviceId.hashCode();
    result = 31 * result + dateOfVisit.hashCode();
    return result;
  }

  @Override
  public String getFindAllQueryName()
  {
    return FIND_ALL;
  }

  @Override
  public int compareTo(Visit o)
  {
    return this.getDateOfVisit().compareTo(o.getDateOfVisit());
  }
}
