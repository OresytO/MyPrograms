package com.rebok3J.model.impl;

import java.util.Date;

import javax.annotation.Nonnull;
import javax.persistence.*;

import com.rebok3J.model.ModelObjectImpl;
import com.rebok3J.model.ServiceQueryHolder;

/**
 *
 *
 * @author OrestO
 * @since 3/12/2015
 */
@Entity
@Table(name = Service.SERVICE_TABLE)
@NamedNativeQueries({
    @NamedNativeQuery(name = ServiceQueryHolder.GET_ALL_SERVICES_FOR_SELECT, query = ServiceQueryHolder.GET_ALL_SERVICES_FOR_SELECT_QUERY)
})
@NamedQueries({
    @NamedQuery(name = ServiceQueryHolder.FIND_ALL, query = ServiceQueryHolder.FIND_ALL_QUERY)
})
public class Service extends ModelObjectImpl<Service> implements ServiceQueryHolder
{

  private static final long serialVersionUID = 1L;

  public static final String SERVICE_ENTITY = "Service";
  public static final String SERVICE_TABLE = "\"service\"";

  @Id
  @SequenceGenerator(name = ID_SEQ, sequenceName = ID_SEQ, allocationSize = 1)
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = ID_SEQ)
  @Column(name = ID_COLUMN)
  private Long id;
  public static final String ID_COLUMN = "id";
  public static final String ID_SEQ = "service_id_seq";

  @Column(name = NAME_COLUMN, nullable = false)
  private String name;
  public static final String NAME_COLUMN = "name";

  @Column(name = TYPE_COLUMN, nullable = false)
  private String type;
  public static final String TYPE_COLUMN = "type";

  @Column(name = LAMP_DEFAULT_RESOURCE_COLUMN, nullable = true)
  private Integer lampDefaultResource;
  public static final String LAMP_DEFAULT_RESOURCE_COLUMN = "lamp_default_resource";

  @Column(name = LAMP_TIME_WORKED_COLUMN, nullable = true)
  private Integer lampTimeWorked;
  public static final String LAMP_TIME_WORKED_COLUMN = "lamp_time_worked";

  @Column(name = AIRING_DEFAULT_RESOURCE_COLUMN, nullable = true)
  private Integer airingDefaultResource;
  public static final String AIRING_DEFAULT_RESOURCE_COLUMN = "airing_default_resource";

  @Column(name = AIRING_TIME_WORKED_COLUMN, nullable = true)
  private Integer airingTimeWorked;
  public static final String AIRING_TIME_WORKED_COLUMN = "airing_time_worked";

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

  public Integer getLampDefaultResource()
  {
    return lampDefaultResource;
  }

  public void setLampDefaultResource(Integer lampDefaultResource)
  {
    this.lampDefaultResource = lampDefaultResource;
  }

  public Integer getLampTimeWorked()
  {
    return lampTimeWorked;
  }

  public void setLampTimeWorked(Integer lampTimeWorked)
  {
    this.lampTimeWorked = lampTimeWorked;
  }

  public String getType()
  {
    return type;
  }

  public void setType(String type)
  {
    this.type = type;
  }

  public Date getLastUpdated()
  {
    return lastUpdated;
  }

  public void setLastUpdated(Date lastUpdated)
  {
    this.lastUpdated = lastUpdated;
  }

  public Integer getAiringDefaultResource()
  {
    return airingDefaultResource;
  }

  public void setAiringDefaultResource(Integer airingDefaultResource)
  {
    this.airingDefaultResource = airingDefaultResource;
  }

  public Integer getAiringTimeWorked()
  {
    return airingTimeWorked;
  }

  public void setAiringTimeWorked(Integer airingTimeWorked)
  {
    this.airingTimeWorked = airingTimeWorked;
  }

  @Override
  public int hashCode()
  {
    return super.hashCode(id);
  }

  @Override
  public boolean equals(Object obj)
  {
    return obj instanceof Service && super.equals(this, (Service) obj);
  }

  @Override
  public String getFindAllQueryName()
  {
    return FIND_ALL;
  }

  @Override
  public String getAllServicesForSelect()
  {
    return GET_ALL_SERVICES_FOR_SELECT;
  }

  @Override
  public int compareTo(@Nonnull Service obj)
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
