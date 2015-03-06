package org.patchBuilder.prometeus.week1;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

/**
 *
 * @author olozynskyy
 * @since 3.7.0
 */
public class InputDataParser
{
  public static List<ParseResult> parse(InputStream inputStream) throws IOException
  {
    List<ParseResult> result = new ArrayList<>();
    ParseResult parseResult = new ParseResultImpl();
    Scanner scanner = new Scanner(inputStream);
    String line;

    boolean isValueCounter = false;
    Map<Integer, List<Integer>> counterMap = null;
    Integer mapKey;
    List<Integer> valuesList;

    while (scanner.hasNextLine())
    {
      line = scanner.nextLine();
      if (line.isEmpty())
      {
        result.add(parseResult);
        parseResult = new ParseResultImpl();
      }
      // parse(line, parseResult);

      if (isValueCounter && !line.isEmpty())
      {
        mapKey = Integer.valueOf(line.substring(0, line.indexOf(" ")));
        valuesList = new ArrayList<>();

        int valStart = line.indexOf(" [") + 2;
        int valEnd = line.indexOf(", ");
        valuesList.add(Integer.valueOf(line.substring(valStart, valEnd)));
        valStart = valEnd + 2;
        valEnd = line.indexOf(", ", valStart);
        valuesList.add(Integer.valueOf(line.substring(valStart, valEnd)));
        valStart = valEnd + 2;
        valEnd = line.indexOf("]", valStart);
        valuesList.add(Integer.valueOf(line.substring(valStart, valEnd)));

        counterMap.put(mapKey, valuesList);
        parseResult.setCounterMap(counterMap);
      }
      else if (line.isEmpty())
      {
        isValueCounter = false;
      }
      else if (line.contains("X: "))
      {
        parseResult.setValueX(line.substring(3, line.length()));
      }
      else if (line.contains("Y: "))
      {
        parseResult.setValueY(line.substring(3, line.length()));
      }
      else if (line.contains("Z: "))
      {
        parseResult.setValueZ(line.substring(3, line.length()));
      }
      else if (line.contains("Value counter"))
      {
        isValueCounter = true;
        counterMap = new HashMap<>();
      }
    }
    if (!result.contains(parseResult))
    {
      result.add(parseResult);
    }
    scanner.close();
    inputStream.close();
    return result;
  }
}
