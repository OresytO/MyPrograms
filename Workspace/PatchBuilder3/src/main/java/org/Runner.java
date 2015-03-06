package org;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.patchBuilder.msOffice.Excel;

/**
 * Created by olozyn on 6/27/2014.
 */

public class Runner
{

  public static final String INPUT_FILE_PATH1 = "C:\\Users\\olozyn\\Desktop\\Copy of R-IT-Chcklst.xls";
  public static final String INPUT_FILE_PATH2 = "D:\\working\\3.6.0\\Trunk\\blue-web\\schawk-parts-web\\src\\resources\\settingsdescriptions.properties";
  public static final String OUTPUT_FILE_PATH = "D:\\output\\settingsdescriptions.properties";

  public static void main(String[] args)
  {
    System.out.println("BEGIN!!!");
    // ------getting infomation from file-------- //
    Row row = Excel.open(INPUT_FILE_PATH1, 9, 1);
    if (row == null)
      throw new RuntimeException("row == null :(");
    // List<String> headers = Excel.getAll(row);
    Sheet sheet = Excel.getSheet();

    Map<String, String> mapFromExcel = createMap(sheet, 1, 173);

    File output = new File(OUTPUT_FILE_PATH);
    try (FileWriter fw = new FileWriter(output))
    {
      for (String key : mapFromExcel.keySet())
      {
        String str = key + "=" + mapFromExcel.get(key) + "\n";
        fw.write(str);
      }
    }
    catch (IOException e)
    {
      e.printStackTrace();
    }
    System.out.println("END!!!");

  }

  private static Map<String, String> createMap(Sheet sheet, int fromRow, int toRow)
  {
    if (fromRow > toRow)
    {
      int temp = fromRow;
      fromRow = toRow;
      toRow = temp;
    }
    HashMap<String, String> map = new LinkedHashMap<>();
    for (Row row : Excel.getRows(sheet))
    {
      if (row.getRowNum() >= fromRow && row.getRowNum() <= toRow)
      {
        String key = Excel.get(row, 0);
        String value = Excel.get(row, 4).replaceAll("\n", " ");
        if (key.isEmpty())
          continue;
        map.put(key, value);
      }
      else if (row.getRowNum() > toRow)
        break;
    }
    return map;
  }
}
