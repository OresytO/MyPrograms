package org.patchBuilder.properties;

import java.util.Map;

/**
 * @author olozynskyy
 * @since 3.7.0
 */
public class SqlWriter
{
  private StringBuilder stringBuilder;

  public SqlWriter()
  {
    this.stringBuilder = new StringBuilder();
  }

  public SqlWriter insertStatement()
  {
    stringBuilder.append("BEGIN\n\tTRUNCATE TABLE SDS_SETTINGS_PROPERTIES;\n\tINSERT INTO SDS_SETTINGS_PROPERTIES ([ID], [BEAN_NAME], [PROPERTY_NAME], [CURRENT_VALUE], [DEFAULT_VALUE], [DESCRIPTION], [SEQUENCE], [VERSION_ADDED], [PROPERTY_TYPE]) VALUES\n");
    return this;
  }

  public SqlWriter valuesStatement(Profile profile)
  {
    stringBuilder.append("\n/*---------------------------------- START ").append(profile.getTypeName()).append(" profile ----------------------------------*/");
    generateValuesStatements(profile.getSystemMap());
    generateValuesStatements(profile.getSettingsMap());
    stringBuilder.append("\n/*---------------------------------- END ").append(profile.getTypeName()).append(" profile ------------------------------------*/\n");

    return this;
  }

  private void generateValuesStatements(Map<String, Settings> map)
  {
    for (Settings tempSettings : map.values())
    {
      stringBuilder.append("\n\t('").append(tempSettings.getId()).append("', '").append(tempSettings.getBeanName()).append("', '").append(tempSettings.getPropertyName()).append("', '").append(tempSettings.getCurrentValue()).append("', '")
          .append(tempSettings.getDefaultValue()).append("', '").append(tempSettings.getDescription()).append("', ").append(tempSettings.getSequence()).append(", ")
          .append(tempSettings.getVersionAdded()).append(", ").append(tempSettings.getType()).append("),");
    }
  }

  public SqlWriter endGoStatement()
  {
    int lastComa = stringBuilder.lastIndexOf(",");
    stringBuilder.replace(lastComa, lastComa + 1, ";");
    stringBuilder.append("END;\nGO\n");

    return this;
  }

  public String write()
  {
    return stringBuilder.toString();
  }
}
