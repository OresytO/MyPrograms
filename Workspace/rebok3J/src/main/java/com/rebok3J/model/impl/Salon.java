package com.rebok3J.model.impl;

import java.util.Date;

import javax.persistence.*;

import com.rebok3J.model.SalonQueryHolder;

/**
 *
 *
 * @author OrestO
 * @since 3/12/2015
 */
@Entity
@Table(name = Salon.SALON_TABLE)
@NamedQueries({ @NamedQuery(name = SalonQueryHolder.FIND_ALL, query = SalonQueryHolder.FIND_ALL_QUERY) })
public class Salon implements SalonQueryHolder, Comparable<Salon>
{

  public static final String SALON_ENTITY = "Salon";
  public static final String SALON_TABLE = "\"SALON\"";

  @Id
  @GeneratedValue
  @Column(name = ID_COLUMN)
  private long id;
  public static final String ID_COLUMN = "ID";

  @Column(name = NAME_COLUMN, nullable = false)
  private String name;
  public static final String NAME_COLUMN = "NAME";

  @Column(name = ADDRESS_COLUMN, nullable = false)
  private String address;
  public static final String ADDRESS_COLUMN = "ADDRESS";

  @Temporal(TemporalType.TIMESTAMP)
  @Column(name = CREATE_DATE_COLUMN, nullable = false)
  private Date createDate;
  public static final String CREATE_DATE_COLUMN = "CREATE_DATE";

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

  public String getAddress()
  {
    return address;
  }

  public void setAddress(String address)
  {
    this.address = address;
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
  public int compareTo(Salon o)
  {
    return this.getName().compareTo(o.getName());
  }
}
