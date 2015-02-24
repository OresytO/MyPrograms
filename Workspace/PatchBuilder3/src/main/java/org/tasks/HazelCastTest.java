package org.tasks;

import com.hazelcast.config.Config;
import com.hazelcast.core.Hazelcast;
import com.hazelcast.core.HazelcastInstance;

import java.io.BufferedReader;
import java.io.Console;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Serializable;
import java.util.concurrent.ConcurrentMap;

/**
 * @author olozynskyy
 * @since 3.7.0.
 */
public class HazelCastTest
{

  public static void main(String... args) throws Exception
  {
    Config config = new Config();
    HazelcastInstance h = Hazelcast.newHazelcastInstance(config);
    ConcurrentMap<String, SettingsProperty> map = h.getMap("orest-map");
    map.put("key", new  SettingsProperty("firstProperty", "value for first property"));

    System.out.println(map.get("key"));

    while (true)
    {
      // System.out.print("Enter something:");
      // String input = System.console().readLine();
      BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
      System.out.println("Enter String");
      String input = br.readLine();
      if (input.equalsIgnoreCase("exit"))
      {
        break;
      }
      else
      {
        String command = input;
        String key = "";
        String value = "";
        SettingsProperty settingsProperty = null;

        if (input.contains(" "))
        {
          String[] strings = input.split(" ");
          command = strings[0];
          key = strings[1];
          if (strings.length >= 2)
          {
            value = strings[2];
            settingsProperty = new SettingsProperty(key, value);
          }
        }
        switch (command)
        {
        case "put":
          System.out.println("key [" + key + "] value [" + value + "]");
          map.put(key, settingsProperty);
          break;
        case "get":
          System.out.println(map.get(key));
          break;
        case "getAll":
          System.out.println(map.entrySet());
          break;
        }
      }
    }
  }

  private static class SettingsProperty implements Serializable
  {
    private String beanName = "applicationSettings";
    private String propertyName;
    private String currentValue;

    private SettingsProperty() {
    }

    private SettingsProperty(String propertyName, String currentValue) {
      this.propertyName = propertyName;
      this.currentValue = currentValue;
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

    @Override
    public String toString() {
      return "SettingsProperty{" +
          "beanName='" + beanName + '\'' +
          ", propertyName='" + propertyName + '\'' +
          ", currentValue='" + currentValue + '\'' +
          "}";
    }
  }
}
