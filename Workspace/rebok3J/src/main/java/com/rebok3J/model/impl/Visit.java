package com.rebok3J.model.impl;

import java.util.Date;

import javax.persistence.*;

import org.joda.time.format.DateTimeFormat;

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
  private Visitor visitor;
  public static final String VISITOR_ID_COLUMN = "VISITOR_ID";

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = SERVICE_ID_COLUMN, nullable = false)
  private Service service;
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

  public Date getCreateDate()
  {
    return dateOfVisit;
  }

  public void setCreateDate(Date dateOfVisit)
  {
    this.dateOfVisit = dateOfVisit;
  }

  public Visitor getVisitor()
  {
    return visitor;
  }

  public Service getService()
  {
    return service;
  }

  public void setService(Service service)
  {
    this.service = service;
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

    if (!visitor.equals(visit.visitor))
      return false;
    if (!service.equals(visit.service))
      return false;
    return dateOfVisit.equals(visit.dateOfVisit);

  }

  @Override
  public int hashCode()
  {
    int result = visitor.hashCode();
    result = 31 * result + service.hashCode();
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

  public String getFormattedDateofVisit()
  {
    return getFormattedDateofVisit("dd-MM-yyyy hh:mm");
  }

  public String getFormattedDateofVisit(String format)
  {
    return DateTimeFormat.forPattern(format).print(dateOfVisit.getTime());
  }
}
