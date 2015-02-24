package org.patchBuilder.prometeus.week1;

import java.util.List;
import java.util.Map;

/**
 * @author olozynskyy
 * @since 3.7.0.
 */
public class ParseResultImpl implements ParseResult
{
  private String valueX;
  private String valueY;
  private String valueZ;
  private Map<Integer, List<Integer>> counterMap;

  @Override
  public String getValueX()
  {
    return valueX;
  }

  @Override
  public void setValueX(String valueX)
  {
    this.valueX = valueX;
  }

  @Override
  public String getValueY()
  {
    return valueY;
  }

  @Override
  public void setValueY(String valueY)
  {
    this.valueY = valueY;
  }

  @Override
  public String getValueZ()
  {
    return valueZ;
  }

  @Override
  public void setValueZ(String valueZ)
  {
    this.valueZ = valueZ;
  }

  @Override
  public Map<Integer, List<Integer>> getCounterMap()
  {
    return counterMap;
  }

  @Override
  public void setCounterMap(Map<Integer, List<Integer>> counterMap)
  {
    this.counterMap = counterMap;
  }
}
