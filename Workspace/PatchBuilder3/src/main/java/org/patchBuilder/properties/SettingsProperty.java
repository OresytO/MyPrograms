package org.patchBuilder.properties;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author olozynskyy
 * @since 3.7.0.
 */

/**
 * Class used to represent properties in DB
 *
 * @author olozynskyy
 * @since 3.7.0.
 */

@Entity
@Table(name = "tbl_SETTINGS_PROPERTIES")
public class SettingsProperty
{

  public static final String TABLE_NAME = "tbl_SETTINGS_PROPERTIES";

  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  @Column(name = ID_COLUMN)
  private long id;
  public static final String ID_COLUMN = "ID";

  @Column(name = BEAN_NAME_COLUMN, nullable = false, columnDefinition = "VARCHAR(255)")
  private String beanName;
  public static final String BEAN_NAME_COLUMN = "BEAN_NAME";

  @Column(name = PROPERTY_NAME_COLUMN, nullable = false)
  private String propertyName;
  public static final String PROPERTY_NAME_COLUMN = "PROPERTY_NAME";

  @Column(name = CURRENT_VALUE_COLUMN, nullable = false)
  private String currentValue;
  public static final String CURRENT_VALUE_COLUMN = "CURRENT_VALUE";

  @Column(name = DEFAULT_VALUE_COLUMN, nullable = false)
  private String defaultValue;
  public static final String DEFAULT_VALUE_COLUMN = "DEFAULT_VALUE";

  @Column(name = DESCRIPTION_COLUMN, nullable = false, columnDefinition = "VARCHAR(2000) DEFAULT ''", length = 2000)
  private String description;
  public static final String DESCRIPTION_COLUMN = "DESCRIPTION";

  public static final String DELIMITER = ".";

  public SettingsProperty()
  {

  }

  public String getBeanName()
  {
    return beanName;
  }

  public void setBeanName(String beanName)
  {
    this.beanName = beanName;
  }

  public String getPropertyName()
  {
    return propertyName;
  }

  public void setPropertyName(String propertyName)
  {
    this.propertyName = propertyName;
  }

  public String getCurrentValue()
  {
    return currentValue;
  }

  public void setCurrentValue(String currentValue)
  {
    this.currentValue = currentValue;
  }

  public String getDefaultValue()
  {
    return defaultValue;
  }

  public void setDefaultValue(String defaultValue)
  {
    this.defaultValue = defaultValue;
  }

  public String getDescription()
  {
    return description;
  }

  public void setDescription(String description)
  {
    this.description = description;
  }
}