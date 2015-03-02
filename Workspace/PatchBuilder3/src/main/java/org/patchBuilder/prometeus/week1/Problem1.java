package org.patchBuilder.prometeus.week1;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author olozynskyy
 * @since 3.7.0
 */
public class Problem1
{
  public static void main(String... args) throws IOException
  {
    // String filePath = "resources.InputForAlgo/Week1Problem1.txt";
    // List<ParseResult> parseResult =
    // InputDataParser.parse(Thread.currentThread().getContextClassLoader().getResource(filePath).openStream());
    String filePath = "D:\\MyPrograms\\Workspace\\PatchBuilder3\\src\\main\\java\\resources.InputForAlgo\\Week1Problem1.txt";
    List<ParseResult> parseResult = InputDataParser.parse(new FileInputStream(filePath));
    System.out.println(parseResult.get(0).getCounterMap());
  }
}
