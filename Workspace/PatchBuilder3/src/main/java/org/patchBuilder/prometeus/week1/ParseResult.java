package org.patchBuilder.prometeus.week1;

import java.util.List;
import java.util.Map;

/**
 * @author olozynskyy
 * @since 3.7.0.
 */
public interface ParseResult
{
  String getValueX();

  void setValueX(String valueX);

  String getValueY();

  void setValueY(String valueY);

  String getValueZ();

  void setValueZ(String valueZ);

  Map<Integer, List<Integer>> getCounterMap();

  void setCounterMap(Map<Integer, List<Integer>> counterMap);
}
