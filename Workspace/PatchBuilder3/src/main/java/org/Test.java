package org;

import java.util.LinkedHashMap;
import java.util.Map;

class SettingsProperty
{
  public String propertyName;
  public String propertyValue;

  SettingsProperty(String propertyName, String propertyValue) {
    this.propertyName = propertyName;
    this.propertyValue = propertyValue;
  }
}

class PropertyHolder
{
  public Map<String, SettingsProperty> propertyMap;

  public PropertyHolder(Map<String, SettingsProperty> propertyMap) {
    this.propertyMap = propertyMap;
  }
}

class C
{
  public static Map<String, SettingsProperty> getMap(SettingsProperty ... properties)
  {
    Map<String, SettingsProperty> map = new LinkedHashMap<>();

    for (SettingsProperty settingsProperty : properties)
    {
      map.put(settingsProperty.propertyName, settingsProperty);
    }

    return map;
  }
}

public class Test
{

  public static void main(String[] args)
  {
    PropertyHolder propertyHolder = new PropertyHolder(C.getMap(
        new SettingsProperty("prop1", "value1"),
        new SettingsProperty("prop2", "value2"),
        new SettingsProperty("prop3", "value3")));

    SettingsProperty prop1 = propertyHolder.propertyMap.get("prop1");
    SettingsProperty prop2 = propertyHolder.propertyMap.get("prop2");
    SettingsProperty prop3 = propertyHolder.propertyMap.get("prop3");

    System.out.println("//---------------------1------------------------//");
    System.out.println(prop1.propertyName + ", " + prop1.propertyValue);
    System.out.println(prop2.propertyName + ", " + prop2.propertyValue);
    System.out.println(prop3.propertyName + ", " + prop3.propertyValue);

    propertyHolder.propertyMap.put("prop1", new SettingsProperty("prop1", "value3"));
    propertyHolder.propertyMap.put("prop2", new SettingsProperty("prop2", "value1"));
    propertyHolder.propertyMap.put("prop3", new SettingsProperty("prop3", "value2"));

    System.out.println("//--------------------2-------------------------//");
    System.out.println(prop1.propertyName + ", " + prop1.propertyValue);
    System.out.println(prop2.propertyName + ", " + prop2.propertyValue);
    System.out.println(prop3.propertyName + ", " + prop3.propertyValue);

    propertyHolder.propertyMap.get("prop1").propertyValue = "value3";
    propertyHolder.propertyMap.get("prop2").propertyValue = "value1";
    propertyHolder.propertyMap.get("prop3").propertyValue = "value2";

    System.out.println("//--------------------3-------------------------//");
    System.out.println(prop1.propertyName + ", " + prop1.propertyValue);
    System.out.println(prop2.propertyName + ", " + prop2.propertyValue);
    System.out.println(prop3.propertyName + ", " + prop3.propertyValue);

    prop1.propertyValue = "value3";
    prop2.propertyValue = "value1";
    prop3.propertyValue = "value2";

    System.out.println("//--------------------4-------------------------//");
    System.out.println(prop1.propertyName + ", " + prop1.propertyValue);
    System.out.println(prop2.propertyName + ", " + prop2.propertyValue);
    System.out.println(prop3.propertyName + ", " + prop3.propertyValue);

    System.out.println("//--------------------5-------------------------//");
    System.out.println(prop1 + ", " + propertyHolder.propertyMap.get("prop1"));
    System.out.println(prop2 + ", " + propertyHolder.propertyMap.get("prop2"));
    System.out.println(prop3 + ", " + propertyHolder.propertyMap.get("prop3"));
  }
}
