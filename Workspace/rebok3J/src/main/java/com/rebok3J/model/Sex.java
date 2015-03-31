package com.rebok3J.model;

import org.apache.commons.lang3.StringUtils;

/**
 * @author OrestO
 * @since 3/31/2015
 */
public enum Sex {
  MAN("Man", "add.visitor.form.sex.man"), WOMAN("Woman", "add.visitor.form.sex.woman");

  private String sexName;
  private String messageKey;

  Sex(String sexName, String messageKey)
  {
    this.sexName = sexName;
    this.messageKey = messageKey;
  }

  public String getSexName()
  {
    return sexName;
  }

  public String getMessageKey()
  {
    return messageKey;
  }

  public static Sex getValueOf(String sex)
  {
    if (!StringUtils.isNumeric(sex))
    {
      return valueOf(sex);
    }
    int ordinal = Integer.parseInt(sex);

    if (ordinal == Sex.MAN.ordinal())
    {
      return Sex.MAN;
    }
    else if (ordinal == Sex.WOMAN.ordinal())
    {
      return Sex.WOMAN;
    }

    throw new IllegalArgumentException("Can not convert String [" + sex + "] to any available sex instances");
  }
}
