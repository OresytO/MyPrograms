package org.tasks;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.patchBuilder.msOffice.Excel;
import org.patchBuilder.templates.ReviewTagFixQuery;

public class PRR_9710
{
  public static final String INPUT_FILE_PATH = "D:\\input\\starwood_tags_locale_mapping.xlsx";
  public static final String OUTPUT_FILE_PATH = "D:\\output\\PRR_9710(1).sql";

  public static void main(String[] args)
  {
    System.out.println("BEGIN!!!");
    // ------getting infomation from file-------- //
    Row row = Excel.open(INPUT_FILE_PATH, 0, 0);
    if (row == null)
      throw new RuntimeException("row == null :(");
    List<String> localeList = Excel.getAll(row);
    Map<String, List<String>> tagMap = createMap(Excel.getSheet(), 1, 20);

    // --------------building Query-------------- //
    ReviewTagFixQuery query = new ReviewTagFixQuery();
    query.build(tagMap, localeList);
    query.write2File(new File(OUTPUT_FILE_PATH));
    System.out.println("END!!!");

  }

  private static Map<String, List<String>> createMap(Sheet sheet, int fromRow, int toRow)
  {
    if (fromRow > toRow)
    {
      int temp = fromRow;
      fromRow = toRow;
      toRow = temp;
    }
    HashMap<String, List<String>> map = new HashMap<>();
    for (Row row : Excel.getRows(sheet))
    {
      if (row.getRowNum() >= fromRow && row.getRowNum() <= toRow)
      {
        List<String> tagList = Excel.getAll(row);
        if (tagList.size() <= 0)
          continue;
        map.put(tagList.remove(0), tagList);
      }
      else if (row.getRowNum() > toRow)
        break;
    }
    return map;
  }
}
