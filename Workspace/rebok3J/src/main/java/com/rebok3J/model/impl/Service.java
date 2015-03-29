package com.rebok3J.model.impl;

import java.util.Date;

import javax.persistence.*;

import com.rebok3J.model.ServiceQueryHolder;

/**
 *
 *
 * @author OrestO
 * @since 3/12/2015
 */
@Entity
@Table(name = Service.SERVICE_TABLE)
@NamedQueries({ @NamedQuery(name = ServiceQueryHolder.FIND_ALL, query = ServiceQueryHolder.FIND_ALL_QUERY) })
public class Service implements ServiceQueryHolder, Comparable<Service>
{

  public static final String SERVICE_ENTITY = "Service";
  public static final String SERVICE_TABLE = "\"SERVICE\"";

  @Id
  @GeneratedValue
  @Column(name = ID_COLUMN)
  private long id;
  public static final String ID_COLUMN = "ID";

  @Column(name = NAME_COLUMN, nullable = false)
  private String name;
  public static final String NAME_COLUMN = "NAME";

  @Column(name = TYPE_COLUMN, nullable = false)
  private String type;
  public static final String TYPE_COLUMN = "TYPE";

  @Column(name = LAMP_DEFAULT_RESOURCE_COLUMN, nullable = true)
  private Integer lampDefaultResource;
  public static final String LAMP_DEFAULT_RESOURCE_COLUMN = "LAMP_DEFAULT_RESOURCE";

  @Column(name = LAMP_TIME_WORKED_COLUMN, nullable = true)
  private Integer lampTimeWorked;
  public static final String LAMP_TIME_WORKED_COLUMN = "LAMP_TIME_WORKED";

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

  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  @Override
  public boolean equals(Object o)
  {
    if (this == o)
      return true;
    if (o == null || getClass() != o.getClass())
      return false;

    Service service = (Service) o;

    if (!name.equals(service.name))
      return false;
    return type.equals(service.type);

  }

  @Override
  public int hashCode()
  {
    int result = name.hashCode();
    result = 31 * result + type.hashCode();
    return result;
  }

  @Override
  public String getFindAllQueryName()
  {
    return FIND_ALL;
  }

  @Override
  public int compareTo(Service o)
  {
    return this.getName().compareTo(o.getName());
  }
}
