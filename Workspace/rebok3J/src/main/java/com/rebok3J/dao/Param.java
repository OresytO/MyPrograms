package com.rebok3J.dao;

import java.util.ArrayList;
import java.util.List;

/**
 * @author OrestO
 * @since 3/25/2015
 */
public class Param
{
  private String name;
  private String value;

  private Param(String name, String value)
  {
    this.name = name;
    this.value = value;
  }

  public static Param get(String key, String value)
  {
    return new Param(key, value);
  }

  public static List<Param> get(String... values)
  {
    if (values.length % 2 != 0)
    {
      throw new IllegalArgumentException("Can't create parameters, get values.length " + values.length);
    }
    List<Param> paramList = new ArrayList<>(values.length / 2);
    for (int i = 0; i < values.length;)
    {
      paramList.add(Param.get(values[i++], values[i++]));
    }
    return paramList;
  }

  public String getName()
  {
    return name;
  }

  public void setName(String name)
  {
    this.name = name;
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
