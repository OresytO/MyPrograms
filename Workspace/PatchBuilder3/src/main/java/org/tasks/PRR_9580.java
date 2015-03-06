package org.tasks;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Scanner;

public class PRR_9580
{
  public static final String INPUT_EX_ID = "D:\\input\\result.txt";
  public static final String INPUT_PROD_FEED = "D:\\input\\Test_product_feed_Orbitz.xml";
  public static final String OUTPUT_FILE_PATH = "D:\\output\\stg_product_feed_Orbitz.xml";

  public static void main(String[] args)
  {

    try
    {
      Scanner scanner = new Scanner(new File(INPUT_EX_ID));
      LinkedList<Integer> exIDs = new LinkedList<>();
      int i = 0;
      while (scanner.hasNextLine())
      {
        exIDs.add(Integer.parseInt(scanner.nextLine()));
      }

      scanner = new Scanner(new File(INPUT_PROD_FEED));
      StringBuilder result = new StringBuilder();
      String tempStr = null;
      i = 0;
      while (scanner.hasNextLine())
      {
        tempStr = scanner.nextLine();
        Iterator it = exIDs.iterator();
        while (it.hasNext())
        {
          if (tempStr.contains("<ExternalId>" + it.next() + "</ExternalId>"))
          {
            i++;
            result.append(tempStr);
            it.remove();
            break;
          }
        }
      }

      FileWriter fw = new FileWriter(new File(OUTPUT_FILE_PATH));
      System.out.println(i);
      fw.write(result.toString());
      fw.close();

    }
    catch (IOException e)
    {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
  }

}
