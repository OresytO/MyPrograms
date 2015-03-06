package org.patchBuilder.query;

import org.patchBuilder.utils.CONST;
import org.patchBuilder.utils.Validator;

public class CreateTable
{
  private static StringBuilder temp = new StringBuilder();
  private static StringBuilder query = new StringBuilder();
  private static int expCount = 0;

  public static void begin(String tableName, String field)
  {
    if (expCount >= 1)
      throw new IllegalArgumentException("You must end previouse CreateTable block before begin. You can't begin one block twice!!!");
    if (tableName == null || tableName.isEmpty() || Validator.isNull(tableName))
      throw new IllegalArgumentException("You can't create table without name!!!");
    if (field == null || field.isEmpty() || Validator.isNull(field))
      throw new IllegalArgumentException("You can't create table without field!!!");
    temp = new StringBuilder();
    query = new StringBuilder();
    query.append("CREATE TABLE ").append(tableName).append(CONST.EOL).append('(').append(CONST.EOL);
    query.append(CONST.TAB);
    query.append(field).append(", ").append(CONST.EOL);
    expCount = 1;
  }

  public static void add(String field)
  {
    if (field == null || field.isEmpty() || Validator.isNull(field))
      throw new IllegalArgumentException("You can't create table without field!!!");
    temp = new StringBuilder();
    temp.append(CONST.TAB).append(field).append(", ").append(CONST.EOL);
    query.append(temp);
    expCount++;
  }

  public static StringBuilder end()
  {
    expCount = 0;
    query.delete(query.length() - 4, query.length());
    query.append(CONST.EOL).append(");").append(CONST.EOL).append(CONST.EOL);
    return query;
  }
}
