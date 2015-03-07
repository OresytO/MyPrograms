package org.patchBuilder.properties;

import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.Map;

/**
 * @author olozynskyy
 * @since 3.7.0
 */
public class PropertiesSqlGenerator
{
  public static void main(String... args)
  {
    try
    {
      generate("D:\\Result\\newSql.sql");
    }
    catch (IOException e)
    {
      e.printStackTrace();
    }
  }

  public static void generate(String outputPath) throws IOException
  {
    Writer writer = new FileWriter(outputPath);
    SqlWriter sqlWriter = new SqlWriter().insertStatement();

    int ids = 0;
//    for (Profile profile : Profile.values())
//    {
      ids = setIds(Profile.CI.getSystemMap(), ids);
      ids = setIds(Profile.CI.getSettingsMap(), ids);
//      sqlWriter.valuesStatement(profile);
//    }

    sqlWriter.valuesStatement(Profile.CI);
    sqlWriter.endGoStatement();

    writer.write(sqlWriter.write().replace(", 'null'", ", null"));

    writer.close();
  }

  public static int setIds(Map<String, Settings> map, int startsFrom)
  {
    for (Settings setting : map.values())
    {
      setting.setId(startsFrom++);
    }
    return startsFrom;
  }
}
