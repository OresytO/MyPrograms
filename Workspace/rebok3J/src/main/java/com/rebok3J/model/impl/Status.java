package com.rebok3J.model.impl;

import java.util.Date;

import javax.annotation.Nonnull;
import javax.persistence.*;

import com.rebok3J.model.ModelObjectImpl;
import com.rebok3J.model.StatusQueryHolder;

/**
 *
 *
 * @author OrestO
 * @since 3/12/2015
 */
@Entity
@Table(name = Status.STATUS_TABLE)
@NamedQueries({
    @NamedQuery(name = StatusQueryHolder.FIND_ALL, query = StatusQueryHolder.FIND_ALL_QUERY)
})
public class Status extends ModelObjectImpl<Status> implements StatusQueryHolder
{

  private static final long serialVersionUID = 1L;

  public static final String STATUS_ENTITY = "Status";
  public static final String STATUS_TABLE = "\"status\"";

  @Id
  @SequenceGenerator(name = ID_SEQ, sequenceName = ID_SEQ, allocationSize = 1)
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = ID_SEQ)
  @Column(name = ID_COLUMN)
  private Long id;
  public static final String ID_COLUMN = "id";
  public static final String ID_SEQ = "status_id_seq";

  @Column(name = NAME_COLUMN, nullable = false)
  private String name;
  public static final String NAME_COLUMN = "name";

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
  public int hashCode()
  {
    return super.hashCode(id);
  }

  @Override
  public boolean equals(Object obj)
  {
    return obj instanceof Status && super.equals(this, (Status) obj);
  }

  @Override
  public int compareTo(@Nonnull Status obj)
  {
    return this.getName().compareTo(obj.getName());
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
