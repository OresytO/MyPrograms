package com.rebok3J.model.impl;

import java.util.Date;

import javax.persistence.*;

import com.rebok3J.model.VisitorQueryHolder;

/**
 * Created by OrestO on 3/12/2015.
 */
@Entity
@Table(name = Visitor.VISITOR_TABLE)
@NamedQueries({ @NamedQuery(name = VisitorQueryHolder.FIND_ALL, query = VisitorQueryHolder.FIND_ALL_QUERY) })
public class Visitor implements VisitorQueryHolder
{

  public static final String VISITOR_ENTITY = "Visitor";
  public static final String VISITOR_TABLE = "\"VISITOR\"";

  @Id
  @GeneratedValue
  @Column(name = ID_COLUMN)
  private long id;
  public static final String ID_COLUMN = "ID";

  @Column(name = NAME_COLUMN, nullable = false)
  private String name;
  public static final String NAME_COLUMN = "NAME";

  @Temporal(TemporalType.TIMESTAMP)
  @Column(name = CREATE_DATE_COLUMN, nullable = false)
  private Date createDate;
  public static final String CREATE_DATE_COLUMN = "CREATE_DATE";

  // @OneToMany(mappedBy = "id")
  // private List<Visitor> visits;

  public long getId()
  {
    return id;
  }

  public void setId(long id)
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
  public boolean equals(Object o)
  {
    if (this == o)
      return true;
    if (o == null || getClass() != o.getClass())
      return false;

    Visitor visitor = (Visitor) o;

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
