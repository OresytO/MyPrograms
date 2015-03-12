package com.rebok3J.model.impl;

import java.util.Date;
import java.util.List;

import javax.persistence.*;

import com.rebok3J.dao.DaoNamedQueries;
import com.rebok3J.model.Visit;
import com.rebok3J.model.Visitor;

/**
 * Created by OrestO on 3/12/2015.
 */
@Entity
@Table(name = VisitorImpl.VISITOR_TABLE)
@NamedQueries({
    @NamedQuery(name = VisitorImpl.FIND_ALL, query = VisitorImpl.FIND_ALL_QUERY)
})
public class VisitorImpl implements Visitor, DaoNamedQueries
{
  public static final String VISITOR_ENTITY = "VisitorImpl";
  public static final String VISITOR_TABLE = "VISITOR";

  public static final String FIND_ALL = "Visitor.findAll";
  public static final String FIND_ALL_QUERY = "select u from " + VISITOR_ENTITY + " u";

  @Id
  @GeneratedValue
  @Column(name = ID_COLUMN)
  private long id;
  public static final String ID_COLUMN = "ID";

  @Column(name = NAME_COLUMN, nullable = false)
  private String name;
  public static final String NAME_COLUMN = "NAME";

  @Column(name = CREATE_DATE_COLUMN, nullable = false, columnDefinition = "DEFAULT CURRENT_TIMESTAMP")
  private Date createDate;
  public static final String CREATE_DATE_COLUMN = "CREATE_DATE";

  @OneToMany(mappedBy = "id")
  private List<Visit> visits;

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
  public String getName()
  {
    return name;
  }

  @Override
  public void setName(String name)
  {
    this.name = name;
  }

  @Override
  public Date getCreateDate()
  {
    return createDate;
  }

  @Override
  public void setCreateDate(Date createDate)
  {
    this.createDate = createDate;
  }

  @Override
  public List<Visit> getVisits()
  {
    return visits;
  }

  @Override
  public void setVisits(List<Visit> visits)
  {
    this.visits = visits;
  }

  @Override
  public boolean equals(Object o)
  {
    if (this == o)
      return true;
    if (o == null || getClass() != o.getClass())
      return false;

    VisitorImpl visitor = (VisitorImpl) o;

    if (createDate != null ? !createDate.equals(visitor.createDate) : visitor.createDate != null)
      return false;
    if (!name.equals(visitor.name))
      return false;

    return true;
  }

  @Override
  public int hashCode()
  {
    int result = name.hashCode();
    result = 31 * result + (createDate != null ? createDate.hashCode() : 0);
    return result;
  }

  @Override
  public String toString()
  {
    return "VisitorImpl{" + "id=" + id + ", name='" + name + '\'' + ", createDate=" + createDate + '}';
  }

  @Override
  public String getFindAll()
  {
    return FIND_ALL;
  }
}
