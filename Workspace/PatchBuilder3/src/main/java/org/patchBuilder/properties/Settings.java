package org.patchBuilder.properties;

/**
 * @author olozynskyy
 * @since 3.7.0
 */
public class Settings implements Comparable<Settings>
{
  private Integer id;
  private String beanName;
  private String propertyName;
  private String currentValue;
  private String defaultValue;
  private String profile;
  private String description;
  private int sequence;
  private String versionAdded;
  private int type;

  public Settings(Integer id, String beanName, String propertyName, String currentValue, String defaultValue, String profile, String description, int sequence, String versionAdded, int type)
  {
    this.id = id;
    this.beanName = beanName;
    this.propertyName = propertyName;
    this.currentValue = currentValue;
    this.defaultValue = defaultValue;
    this.profile = profile;
    this.description = description;
    this.sequence = sequence;
    this.versionAdded = versionAdded;
    this.type = type;
  }

  public Integer getId()
  {
    return id;
  }

  public void setId(Integer id)
  {
    this.id = id;
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

  public String getProfile()
  {
    return profile;
  }

  public void setProfile(String profile)
  {
    this.profile = profile;
  }

  public String getDescription()
  {
    return description;
  }

  public void setDescription(String description)
  {
    this.description = description;
  }

  public int getSequence()
  {
    return sequence;
  }

  public void setSequence(int sequence)
  {
    this.sequence = sequence;
  }

  public String getVersionAdded()
  {
    return versionAdded;
  }

  public void setVersionAdded(String versionAdded)
  {
    this.versionAdded = versionAdded;
  }

  public int getType()
  {
    return type;
  }

  public void setType(int type)
  {
    this.type = type;
  }

  @Override
  public int compareTo(Settings o)
  {
    return this.beanName.compareToIgnoreCase(o.getBeanName()) + this.propertyName.compareToIgnoreCase(o.getPropertyName()) + this.profile.compareToIgnoreCase(o.getProfile());
  }
}