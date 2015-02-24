package org.patchBuilder.prometeus.week1;

import com.sun.istack.internal.NotNull;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

/**
 * @author olozynskyy
 * @since 3.7.0.
 */
public class InputDataParser
{
  public ParseResult parse(@NotNull File file)
  {
    ParseResult parseResult = new ParseResultImpl();
    try {
      Scanner scanner = new Scanner(file);
      String line;
      while (scanner.hasNextLine())
      {
        line = scanner.nextLine();
      }
    } catch (FileNotFoundException e) {
      e.printStackTrace();
    }

    return parseResult;
  }
}
