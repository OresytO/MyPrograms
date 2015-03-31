package com.rebok3J.web.forms.elements;

/**
 * @author OrestO
 * @since 3/30/2015
 */
public class SelectDTO
{
  private Long key;
  private String value;

  public SelectDTO()
  {
  }

  public SelectDTO(Long key, String value)
  {
    this.key = key;
    this.value = value;
  }

  public Long getKey()
  {
    return key;
  }

  public void setKey(Long key)
  {
    this.key = key;
  }

  public String getValue()
  {
    return value;
  }

  public void setValue(String value)
  {
    this.value = value;
  }
}
