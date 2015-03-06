package org.patchBuilder.properties;

import java.io.InputStream;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Scanner;

/**
 * @author olozynskyy
 * @since 3.7.0
 */
public class SimplePropertiesParser
{

  public static Map<String, String> load(InputStream inputStream)
  {
    Map<String, String> properties = new LinkedHashMap<>();
    Scanner scanner = new Scanner(inputStream);

    final int key = 0;
    final int value = 1;

    String[] currentLine;
    while (scanner.hasNextLine())
    {
      currentLine = scanner.nextLine().split("=");
      properties.put(currentLine[key], currentLine[value]);
    }
    return properties;
  }
}
