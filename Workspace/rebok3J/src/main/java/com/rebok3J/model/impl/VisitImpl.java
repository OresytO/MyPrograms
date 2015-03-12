package com.rebok3J.model.impl;

import java.util.Date;

import javax.persistence.*;

import com.rebok3J.dao.DaoNamedQueries;
import com.rebok3J.model.Visit;
import com.rebok3J.model.Visitor;

/**
 * Created by OrestO on 3/12/2015.
 */
@Entity
@Table(name = VisitImpl.VISIT_TABLE)
@NamedQueries({
    @NamedQuery(name = VisitImpl.FIND_ALL, query = VisitImpl.FIND_ALL_QUERY)
})
public class VisitImpl implements Visit, DaoNamedQueries
{
  public static final String VISIT_ENTITY = "VisitImpl";
  public static final String VISIT_TABLE = "VISIT";

  public static final String FIND_ALL = "Visit.findAll";
  public static final String FIND_ALL_QUERY = "select u from " + VISIT_ENTITY + " u";

  @Id
  @GeneratedValue
  @Column(name = ID_COLUMN)
  private long id;
  public static final String ID_COLUMN = "ID";

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = VISITOR_ID_COLUMN, nullable = false)
  private Visitor visitorId;
  public static final String VISITOR_ID_COLUMN = "VISITOR_ID";

  @Column(name = DATE_OF_VISIT_COLUMN, nullable = false, columnDefinition = "DEFAULT CURRENT_TIMESTAMP")
  private Date dateOfVisit;
  public static final String DATE_OF_VISIT_COLUMN = "DATE_OF_VISIT";

  @Override
  public long getId()
  {
    return id;
  }

  @Override
  public void setId(long id)
  {
    this.id = id;
  }

  @Override
  public Visitor getVisitor()
  {
    return visitorId;
  }

  @Override
  public void setVisitorId(Visitor visitorId)
  {
    this.visitorId = visitorId;
  }

  @Override
  public Date getCreateDate()
  {
    return dateOfVisit;
  }

  @Override
  public void setCreateDate(Date dateOfVisit)
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

    VisitImpl visit = (VisitImpl) o;

    if (dateOfVisit != null ? !dateOfVisit.equals(visit.dateOfVisit) : visit.dateOfVisit != null)
      return false;
    if (!visitorId.equals(visit.visitorId))
      return false;

    return true;
  }

  @Override
  public int hashCode()
  {
    int result = visitorId.hashCode();
    result = 31 * result + (dateOfVisit != null ? dateOfVisit.hashCode() : 0);
    return result;
  }

  @Override
  public String toString()
  {
    return "VisitImpl{" + "id=" + id + ", visitorId='" + visitorId + '\'' + ", createDate=" + dateOfVisit + '}';
  }

  @Override
  public String getFindAll()
  {
    return FIND_ALL;
  }
}
