package org.tasks;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Scanner;
import java.util.Set;

import org.springframework.util.DefaultPropertiesPersister;

/**
 * @author olozynskyy
 * @since 3.7.0.
 */
public class SDS_GeneratePropertiesFileFromAllPropertiesFiles
{

  private static final String ROOT_PATH = "D:\\input";
  private static final String SETTINGS_FILE_NAME = "settings.properties";
  private static final String SYSTEM_FILE_NAME = "system.properties";
  private static final String DESCRIPTIONS_ROOT_PATH = "D:\\SDS_BLUE\\3.7.0\\blue-web\\schawk-parts-web\\src\\resources";
  private static final String SETTINGS_DESCRIPTIONS = "settingsdescriptions.properties";
  private static final String SYSTEM_DESCRIPTIONS = "systemdescriptions.properties";
  private static final String OUTPUT_PATH = "D:\\Result";

  private enum Profile {
    DEFAULT("default"), BLUE03D("blue03d"), CI("ci"), BLUESMOKE3("bluesmoke3"), PRODUCTION("production"), QC("qc");

    private String typeName;
    private Map<String, Settings> map = new LinkedHashMap<>();

    Profile(String typeName)
    {
      this.typeName = typeName;
    }

    public String getTypeName()
    {
      return typeName;
    }

    public Map<String, Settings> getMap()
    {
      return map;
    }
  }

  private static class Settings implements Comparable<Settings>
  {
    private Integer id;
    private String beanName;
    private String propertyName;
    private String currentValue;
    private String defaultValue;
    private String profile;
    private int descrId;

    private Settings(Integer id, String beanName, String propertyName, String currentValue, String defaultValue, String profile)
    {
      this.id = id;
      this.beanName = beanName;
      this.propertyName = propertyName;
      this.currentValue = currentValue;
      this.defaultValue = defaultValue;
      this.profile = profile;
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

    public int getDescrId()
    {
      return descrId;
    }

    public void setDescrId(int descrId)
    {
      this.descrId = descrId;
    }

    @Override
    public int compareTo(Settings o)
    {
      return this.beanName.compareToIgnoreCase(o.getBeanName()) + this.propertyName.compareToIgnoreCase(o.getPropertyName()) + this.profile.compareToIgnoreCase(o.getProfile());
    }
  }

  private static class Description implements Comparable<Description>
  {
    private int id;
    private String description;
    private int setId;

    private Description(int id, String description)
    {
      this.id = id;
      this.description = description;
    }

    public int getId()
    {
      return id;
    }

    public void setId(int id)
    {
      this.id = id;
    }

    public String getDescription()
    {
      return description;
    }

    public void setDescription(String description)
    {
      this.description = description;
    }

    public int getSetId()
    {
      return setId;
    }

    public void setSetId(int setId)
    {
      this.setId = setId;
    }

    @Override
    public int compareTo(Description o)
    {
      return this.description.compareToIgnoreCase(o.getDescription());
    }

    @Override
    public boolean equals(Object o)
    {
      if (this == o)
        return true;
      if (o == null || getClass() != o.getClass())
        return false;

      Description that = (Description) o;

      if (description != null ? !description.equals(that.description) : that.description != null)
        return false;

      return true;
    }

    @Override
    public int hashCode()
    {
      return description != null ? description.hashCode() : 0;
    }
  }

  public static void main(String[] args) throws Exception
  {

    // previousMethod();
    // reorderingSQL();
    SingleSQl();
  }

  private static void SingleSQl() throws Exception
  {
    Map<Integer, String> descMap = new LinkedHashMap<>();
    Map<String, Map<String, List<String>>> propMap = new LinkedHashMap<>();

    getMapsFromInitFile(descMap, propMap);

    combinePropertiesAndDescriptions(descMap, propMap.get(Profile.DEFAULT.name()));

    writeSqlToFileFromMaps(propMap.get(Profile.DEFAULT.name()));

  }

  private static void writeSqlToFileFromMaps(Map<String, List<String>> propMap) throws IOException
  {
    File output = new File(OUTPUT_PATH + "\\init3.7.1.sql");
    Writer writer = new FileWriter(output);

    StringBuilder sb = new StringBuilder();
    sb.append("-- ADD PROPERTIES INTO tbl_SETTINGS_PROPERTIES FOR ALL PROFILES\n" + "\n" + "BEGIN\n" + "  TRUNCATE TABLE tbl_SETTINGS_PROPERTIES;\n"
        + "  INSERT INTO SDS_SETTINGS_PROPERTIES ([ID], [BEAN_NAME], [PROPERTY_NAME], [CURRENT_VALUE], [DEFAULT_VALUE], [DESCRIPTION_ID], [PROFILE]) VALUES\n");
    sb.append("\n/*---------------------------------- START ").append(Profile.DEFAULT.name()).append(" profile ----------------------------------*/\n");
    for (List<String> list : propMap.values())
    {
      sb.append("    ('");
      for (String str : list)
      {
        if (str.isEmpty() || str.equalsIgnoreCase(Profile.DEFAULT.name()))
          continue;
        sb.append(str).append("', '");
      }
      sb.replace(sb.lastIndexOf(", '"), sb.lastIndexOf(", '") + 3, "),\n");
    }
    sb.append("/*---------------------------------- END ").append(Profile.DEFAULT.name()).append(" profile ------------------------------------*/\n");
    sb.replace(sb.lastIndexOf(","), sb.lastIndexOf(",") + 1, ";");
    sb.append("END;\nGO\n");
    writer.write(sb.toString());
    writer.close();
  }

  private static void combinePropertiesAndDescriptions(Map<Integer, String> descMap, Map<String, List<String>> propMap) throws IOException
  {
    for (List<String> list : propMap.values())
    {
      Integer id = Integer.parseInt(list.get(5));
      list.set(5, descMap.get(id));
    }
  }

  private static void reorderingSQL() throws Exception
  {

    Map<Integer, String> descMap = new LinkedHashMap<>();
    Map<String, Map<String, List<String>>> propMap = new LinkedHashMap<>();

    getMapsFromInitFile(descMap, propMap);

    makeDescriptionPerProperty(descMap, propMap);

    forwardDescIdToSpecProfile(propMap);

    writeSqlToFileFromMaps(descMap, propMap);
  }

  private static void writeSqlToFileFromMaps(Map<Integer, String> descMap, Map<String, Map<String, List<String>>> propMap) throws IOException
  {
    File output = new File(OUTPUT_PATH + "\\init3.7.1.sql");
    Writer writer = new FileWriter(output);

    StringBuilder sb = new StringBuilder();
    sb.append("-- ADD DESCRIPTIONS OF PROPERTIES INTO tbl_SETTINGS_PROPERTIES_DESCRIPTIONS FOR ALL PROFILES\n\nBEGIN\n  INSERT INTO tbl_SETTINGS_PROPERTIES_DESCRIPTIONS (ID, DESCRIPTION) VALUES\n");
    for (Map.Entry<Integer, String> entry : descMap.entrySet())
    {
      sb.append("    ('").append(entry.getKey()).append("', '").append(entry.getValue()).append("'),\n");
    }
    sb.replace(sb.lastIndexOf(","), sb.lastIndexOf(",") + 1, ";");
    sb.append("END;\nGO\n" + "-- ADD PROPERTIES INTO tbl_SETTINGS_PROPERTIES FOR ALL PROFILES\n" + "\n" + "BEGIN\n" + "  TRUNCATE TABLE tbl_SETTINGS_PROPERTIES;\n"
        + "  INSERT INTO tbl_SETTINGS_PROPERTIES (ID, BEAN_NAME, PROPERTY_NAME, CURRENT_VALUE, DEFAULT_VALUE, DESCRIPTION_ID, [PROFILE]) VALUES\n");
    for (String profile : propMap.keySet())
    {
      sb.append("\n/*---------------------------------- START ").append(profile).append(" profile ----------------------------------*/\n");
      for (List<String> list : propMap.get(profile).values())
      {
        sb.append("    ('");
        for (String str : list)
        {
          sb.append(str).append("', '");
        }
        sb.append("'),\n");
      }
      sb.append("/*---------------------------------- END ").append(profile).append(" profile ------------------------------------*/\n");
    }
    sb.replace(sb.lastIndexOf(","), sb.lastIndexOf(",") + 1, ";");
    sb.append("END;\nGO\n");
    writer.write(sb.toString());
    writer.close();
  }

  private static void forwardDescIdToSpecProfile(Map<String, Map<String, List<String>>> propMap)
  {
    Set<String> set = null;
    for (Profile profile : Profile.values())
    {
      if (profile.equals(Profile.DEFAULT))
        continue;
      Map<String, List<String>> map = propMap.get(Profile.DEFAULT.name());
      for (List<String> list : propMap.get(profile.name()).values())
      {
        list.set(5, map.get(list.get(2)).get(5));
      }
    }
  }

  private static void makeDescriptionPerProperty(Map<Integer, String> descMap, Map<String, Map<String, List<String>>> propMap)
  {
    Set<Integer> descIds = new HashSet<>();
    Map<Integer, String> newDesc = new LinkedHashMap<>();
    int lastId = descMap.size() - 1;
    for (List<String> list : propMap.get(Profile.DEFAULT.name()).values())
    {
      Integer id = Integer.parseInt(list.get(5));
      if (descIds.contains(id))
      {
        System.out.println(id.toString());
        descIds.add(++lastId);
        list.set(5, Integer.toString(lastId));
        newDesc.put(lastId, descMap.get(id));
      }
      else
      {
        descIds.add(id);
      }
    }
    descMap.putAll(newDesc);
  }

  private static void getMapsFromInitFile(Map<Integer, String> descMap, Map<String, Map<String, List<String>>> propMap) throws Exception
  {
    File input = new File("D:\\SDS_BLUE\\3.7.0\\build\\src\\main\\resources\\scripts\\db\\oltp\\convert\\initialize-BLUE3.7.sql");
    Scanner scanner = new Scanner(input);
    String line = null;
    boolean isDesc = false;
    boolean isProp = false;
    String[] items;
    Profile prof = null;
    while (scanner.hasNextLine())
    {
      line = scanner.nextLine();
      if (line.contains("('0', 'No description'),"))
      {
        isDesc = true;
      }
      else if (line.contains("END;"))
      {
        isDesc = false;
      }

      if (isDesc && line.contains("    ('"))
      {
        line = line.replace("    ('", "").replace("'),", "").replace("');", "");
        items = line.split("', '");
        Integer id = Integer.parseInt(items[0]);
        descMap.put(id, items[1].replace("'),", ""));
      }

      if (isProp && line.contains("    ('") && prof != null)
      {
        line = line.replace("    ('", "").replace("'),", "").replace("');", "");
        items = line.split("', '");
        Integer id = Integer.parseInt(items[0]);
        List<String> list = Arrays.asList(items);
        propMap.get(prof.name()).put(list.get(2), list);
      }

      if (line.contains("/*---------------------------------- START "))
      {
        prof = Profile.valueOf(line.substring(line.indexOf("START ") + "START ".length(), line.indexOf(" profile")).toUpperCase());
        propMap.put(prof.name(), new LinkedHashMap<String, List<String>>());
        isProp = true;
      }
      else if (line.contains("/*---------------------------------- END "))
      {
        isProp = false;
      }
    }
    scanner.close();
  }

  private static void previousMethod() throws Exception
  {
    File rootFolder = new File(ROOT_PATH);
    List<File> files = getFiles(rootFolder);
    System.out.println(files.size());
    File output = new File(OUTPUT_PATH + "\\init3.7.sql");
    StringBuilder settBuilder = new StringBuilder();
    Writer writer = new FileWriter(output);
    Map<String, Description> desc = getDescriptions(new File(DESCRIPTIONS_ROOT_PATH + "\\" + SETTINGS_DESCRIPTIONS), new File(DESCRIPTIONS_ROOT_PATH + "\\" + SYSTEM_DESCRIPTIONS));

    for (Profile profile : Profile.values())
    {
      String path;
      Map<String, Settings> tempSettings;
      if (profile.equals(Profile.DEFAULT))
      {
        path = ROOT_PATH + "\\" + Profile.CI.getTypeName() + "\\";
        profile.getMap().putAll(getSettings(profile.getTypeName(), new File(path + SETTINGS_FILE_NAME), new File(path + SYSTEM_FILE_NAME)));
        continue;
      }
      path = ROOT_PATH + "\\" + profile.getTypeName() + "\\";
      tempSettings = getSettings(profile.getTypeName(), new File(path + SETTINGS_FILE_NAME), new File(path + SYSTEM_FILE_NAME));
      Map<String, Settings> defaultSettings = Profile.DEFAULT.getMap();
      for (Settings settings : tempSettings.values())
      {
        Settings defaultSetting = defaultSettings.get(settings.getPropertyName());
        if (defaultSetting == null)
        {
          Profile.DEFAULT.getMap().put(settings.getPropertyName(), settings);
          defaultSetting = Profile.DEFAULT.getMap().get(settings.getPropertyName());
        }
        String currentValue = defaultSetting.getCurrentValue();
        if (!currentValue.equalsIgnoreCase(settings.getCurrentValue()))
        {
          profile.getMap().put(settings.getPropertyName(), settings);
        }
      }
    }
    linkSettingsToDescriptions(desc);
    settBuilder.append("BEGIN\n");
    settBuilder = writeSettingsSQL(settBuilder);
    writer.write("\n-- ADD DESCRIPTIONS OF PROPERTIES INTO tbl_SETTINGS_PROPERTIES_DESCRIPTIONS FOR ALL PROFILES");
    writer.write(writeDescriptionSql(desc).toString());

    writer.write("\n-- ADD PROPERTIES INTO tbl_SETTINGS_PROPERTIES FOR ALL PROFILES");
    writer.write(settBuilder.toString());
    writer.close();
  }

  private static StringBuilder writeSettingsSQL(StringBuilder settBuilder)
  {
    settBuilder.append("\tINSERT INTO tbl_SETTINGS_PROPERTIES ([ID], [BEAN_NAME], [PROPERTY_NAME], [CURRENT_VALUE], [DEFAULT_VALUE], [DESCRIPTION_ID], [PROFILE]) VALUES\n");
    for (Profile profile : Profile.values())
    {
      settBuilder.append("\n/*---------------------------------- START ").append(profile.getTypeName()).append(" profile ----------------------------------*/");
      for (Settings tempSettings : profile.getMap().values())
      {
        settBuilder.append("\n\t('").append(tempSettings.getId()).append("', '").append(tempSettings.getBeanName()).append("', '").append(tempSettings.getPropertyName()).append("', '")
            .append(tempSettings.getCurrentValue()).append("', '").append(tempSettings.getDefaultValue()).append("', '").append(tempSettings.getDescrId()).append("', '")
            .append(tempSettings.getProfile()).append("'),");
      }
      settBuilder.append("\n/*---------------------------------- END ").append(profile.getTypeName()).append(" profile ------------------------------------*/\n");
    }
    int lastComa = settBuilder.lastIndexOf(",");
    settBuilder.replace(lastComa, lastComa + 1, ";");
    settBuilder.append("END;\nGO\n");
    return settBuilder;
  }

  private static StringBuilder writeDescriptionSql(Map<String, Description> descriptions) throws IOException
  {
    StringBuilder builder = new StringBuilder();
    builder.append("\n\nBEGIN\n");
    builder.append("\tINSERT INTO tbl_SETTINGS_PROPERTIES_DESCRIPTIONS ([ID], [DESCRIPTION]) VALUES ");
    for (Description description : descriptions.values())
    {
      builder.append("\n\t('").append(description.getId()).append("', '").append(description.getDescription()).append("'),");
    }
    builder.deleteCharAt(builder.lastIndexOf(","));
    builder.append(";");
    builder.append("\nEND;\nGO\n");

    return builder;
  }

  private static String getProperty(Properties properties, String name)
  {
    StringBuilder property = new StringBuilder(properties.getProperty(name));
    int indexOfSingleQuote = property.indexOf("'");
    if (indexOfSingleQuote >= 0)
    {
      property.insert(indexOfSingleQuote, "'");
    }
    return property.toString();
  }

  private static Map<String, Settings> getSettings(String profile, File... propertiesFiles) throws IOException
  {

    Map<String, Settings> result = new LinkedHashMap<>();
    InputStream inputStream;
    final int BEAN_NAME = 0;
    final int PROPERTY_NAME = 1;
    for (File file : propertiesFiles)
    {
      Properties properties = new Properties();
      DefaultPropertiesPersister defaultPropertiesPersister = new DefaultPropertiesPersister();

      inputStream = new FileInputStream(file);
      defaultPropertiesPersister.load(properties, inputStream);

      for (String name : properties.stringPropertyNames())
      {
        String[] names = name.split("[.]", 2);
        String value = getProperty(properties, name);
        if (result.containsKey(names[PROPERTY_NAME]))
        {
          System.out.println(" duplication: " + names[PROPERTY_NAME] + " containing value [" + result.get(names[PROPERTY_NAME]).getCurrentValue() + "] new value [" + value + "]");
        }
        result.put(names[PROPERTY_NAME], new Settings(0, names[BEAN_NAME], names[PROPERTY_NAME], value, value, profile));
      }

      inputStream.close();
    }
    return result;
  }

  private static Map<String, Description> getDescriptions(File... propertiesFiles) throws IOException
  {
    Properties properties = new Properties();
    DefaultPropertiesPersister defaultPropertiesPersister = new DefaultPropertiesPersister();

    Map<String, Description> result = new LinkedHashMap<>();
    InputStream inputStream;
    int i = 1;
    for (File file : propertiesFiles)
    {

      inputStream = new FileInputStream(file);
      defaultPropertiesPersister.load(properties, inputStream);

      for (String name : properties.stringPropertyNames())
      {
        String value = getProperty(properties, name);
        result.put(name, new Description(0, value.isEmpty() ? "No description" : value));
      }
    }

    for (Description description : result.values())
    {
      if (description.getDescription().equalsIgnoreCase("No description"))
      {
        description.setId(0);
        // description.setDescription("No description");
      }
      else
      {
        description.setId(i++);
      }
    }
    return result;
  }

  private static void linkSettingsToDescriptions(Map<String, Description> descriptions)
  {
    int id = 1;
    for (Profile profile : Profile.values())
    {
      for (String fullName : profile.getMap().keySet())
      {
        Settings tempSettings = profile.getMap().get(fullName);
        Description description = descriptions.get(fullName);
        if (tempSettings != null && description != null)
        {
          tempSettings.setId(id++);
          tempSettings.setDescrId(description.getId());
          // description.setSetId(tempSettings.getId());
        }
        else if (tempSettings != null)
        {
          tempSettings.setId(id++);
          tempSettings.setDescrId(0);
          System.out.println(fullName + " [" + tempSettings + "] [" + description + "]");
        }
        else
        {
          System.err.println("!!!!!!!Something went wrong!!!!!!!!");
        }
      }
    }
  }

  private static List<File> getFiles(File rootFolder)
  {

    List<File> files = new ArrayList<>();

    for (File file : rootFolder.listFiles())
    {
      if (file.isDirectory())
      {
        files.addAll(getFiles(file));
      }
      else
      {
        if (file.getName().equals("settings.properties") || file.getName().equals("system.properties") || file.getName().equals("settingsdescriptions.properties"))
        {
          files.add(file);
        }
      }
    }
    return files;
  }

}
