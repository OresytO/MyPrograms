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
  public static final String SALON_TABLE = "\"salon\"";

  @Id
  @SequenceGenerator(name = ID_SEQ, sequenceName = ID_SEQ, allocationSize = 1)
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = ID_SEQ)
  @Column(name = ID_COLUMN)
  private Long id;
  public static final String ID_COLUMN = "id";
  public static final String ID_SEQ = "salon_id_seq";

  @Column(name = NAME_COLUMN, nullable = false)
  private String name;
  public static final String NAME_COLUMN = "name";

  @Column(name = ADDRESS_COLUMN, nullable = false)
  private String address;
  public static final String ADDRESS_COLUMN = "address";

  @Temporal(TemporalType.TIMESTAMP)
  @Column(name = CREATE_DATE_COLUMN, nullable = false)
  private Date createDate;
  public static final String CREATE_DATE_COLUMN = "create_date";

  @Temporal(TemporalType.TIMESTAMP)
  @Column(name = LAST_UPDATE_TIMESTAMP_COLUMN, nullable = false)
  private Date lastUpdated;
  public static final String LAST_UPDATE_TIMESTAMP_COLUMN = "last_update_timestamp";

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

  public Date getLastUpdated()
  {
    return lastUpdated;
  }

  public void setLastUpdated(Date lastUpdated)
  {
    this.lastUpdated = lastUpdated;
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

  @PrePersist
  public void createdTimestamp()
  {
    createDate = new Date();
    lastUpdated = new Date();
  }

  @PreUpdate
  public void lastUpdatedTimestamp()
  {
    lastUpdated = new Date();
  }
}
