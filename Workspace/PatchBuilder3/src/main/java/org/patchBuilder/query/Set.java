package org.patchBuilder.query;

import org.patchBuilder.utils.CONST;
import org.patchBuilder.utils.Validator;

public class Set
{
  private static StringBuilder temp = new StringBuilder();
  private static StringBuilder query = new StringBuilder();
  private static int expCount = 0;

  // public Set(StringBuilder query) {
  // this.query = query;
  // }

  public static void begin(String field, String value)
  {
    if (expCount >= 1)
      throw new IllegalArgumentException("You must end Set block before begin. You can't begin one block twice!!!");
    temp = new StringBuilder();
    query = new StringBuilder();
    query.append("SET ").append(CONST.EOL);
    if (Validator.isNotNull(value))
    {
      temp.append(CONST.TAB).append(field).append(Oper.EQU).append(CONST.QUO).append(value);
      temp.append(CONST.QUO).append(",").append(CONST.EOL);
      query.append(temp);
      expCount = 1;
    }
  }

  public static StringBuilder end()
  {
    expCount = 0;
    query.deleteCharAt(query.length() - 3);
    return query;
  }

  public static void add(String field, String value)
  {
    if (Validator.isNotNull(value) && expCount >= 1)
    {
      temp = new StringBuilder();
      temp.append(CONST.TAB).append(field).append(Oper.EQU);
      temp.append(CONST.QUO).append(value).append(CONST.QUO).append(",").append(CONST.EOL);
      query.append(temp);
      expCount++;
    }
  }
}
