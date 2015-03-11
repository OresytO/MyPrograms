package org.patchBuilder.properties;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * @author olozynskyy
 * @since 3.7.0
 */
public enum Profile {
  BLUE03D("blue03d"), CI("ci"), BLUESMOKE3("bluesmoke3"), PRODUCTION("production"), QC("qc");

  private String typeName; // folder name

  public static final String SETTINGS_PROPERTIES = "settings.properties";
  public static final String SYSTEM_PROPERTIES = "system.properties";
  public static final String ROOT_FOLDER_OF_PROFILES = "D:\\SDS_BLUE\\3.7.0_DB_properties\\blue-web\\schawk-parts-web\\src\\build\\resources";
  public static final String DESCRIPTIONS_ROOT_PATH = "D:\\SDS_BLUE\\3.7.0_DB_properties\\blue-web\\schawk-parts-web\\src\\resources";
  public static final String SETTINGS_DESCRIPTIONS = "settingsdescriptions.properties";
  public static final String SYSTEM_DESCRIPTIONS = "systemdescriptions.properties";

  private Map<String, Settings> settingsMap = new LinkedHashMap<>();
  private Map<String, Settings> systemMap = new LinkedHashMap<>();
  private int sequence = 0;
  // ------
  Profile(String typeName)
  {
    Map<String, String> systemProperties = null;
    Map<String, String> systemDescriptions = null;
    Map<String, String> settingsProperties = null;
    Map<String, String> settingsDescriptions = null;
    this.typeName = typeName;

    InputStream inputStream = null;

    try
    {
      inputStream = new FileInputStream(Profile.ROOT_FOLDER_OF_PROFILES + "/" + typeName + "/" + Profile.SYSTEM_PROPERTIES);
      systemProperties = SimplePropertiesParser.load(inputStream);
      inputStream = new FileInputStream(Profile.DESCRIPTIONS_ROOT_PATH + "/" + Profile.SYSTEM_DESCRIPTIONS);
      systemDescriptions = SimplePropertiesParser.load(inputStream);

      inputStream = new FileInputStream(Profile.ROOT_FOLDER_OF_PROFILES + "/" + typeName + "/" + Profile.SETTINGS_PROPERTIES);
      settingsProperties = SimplePropertiesParser.load(inputStream);
      inputStream = new FileInputStream(Profile.DESCRIPTIONS_ROOT_PATH + "/" + Profile.SETTINGS_DESCRIPTIONS);
      settingsDescriptions = SimplePropertiesParser.load(inputStream);
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    finally
    {
      if (inputStream != null)
      {
        try
        {
          inputStream.close();
        }
        catch (IOException e)
        {
          e.printStackTrace();
        }
      }
    }

    sequence = 0;
    this.getSystemMap().putAll(fulfillMap(systemProperties, systemDescriptions, 1));
    sequence = 0;
    this.getSettingsMap().putAll(fulfillMap(settingsProperties, settingsDescriptions, 2));
    // ------
  }

  private Map<String, Settings> fulfillMap(Map<String, String> properties, Map<String, String> descriptions, int type)
  {
    Map<String, Settings> result = new LinkedHashMap<>();
    final int BEAN_NAME = 0;
    final int PROPERTY_NAME = 1;
    for (String name : properties.keySet())
    {
      String[] names = name.split("[.]", 2);
      String value = getProperty(properties, name);
      if (result.containsKey(names[PROPERTY_NAME]))
      {
        System.out.println(" duplication: " + names[PROPERTY_NAME] + " containing value [" + result.get(names[PROPERTY_NAME]).getCurrentValue() + "] new value [" + value + "]");
      }
      result.put(names[PROPERTY_NAME], new Settings(0, names[BEAN_NAME], names[PROPERTY_NAME], value, value, this.name(), getProperty(descriptions, names[PROPERTY_NAME]), sequence++, null, type));
    }
    return result;
  }

  public String getTypeName()
  {
    return typeName;
  }

  public Map<String, Settings> getSettingsMap()
  {
    return settingsMap;
  }

  public Map<String, Settings> getSystemMap()
  {
    return systemMap;
  }

  private static String getProperty(Map<String, String> properties, String name)
  {
    StringBuilder property = new StringBuilder();
    property.append(properties.get(name));
    return property.toString().replace("'", "''");
  }
}
