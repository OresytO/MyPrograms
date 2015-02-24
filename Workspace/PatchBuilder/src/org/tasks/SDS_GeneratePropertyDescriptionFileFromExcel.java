package org.tasks;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.patchBuilder.msOffice.Excel;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.TreeMap;

/**
 * @author olozynskyy
 * @since 3.7.0.
 */
public class SDS_GeneratePropertyDescriptionFileFromExcel {

  private static final String PATH_TO_RESULT_FILE = "D:\\Result";
  private static final String PATH_TO_SOURCE_FILE = "D:\\R-IT-Chcklst-3 6.xls";

  public static void main(String[] args) {
    System.out.println("BEGIN!!!");
    // ------getting information from file-------- //
    Row row = Excel.open(PATH_TO_SOURCE_FILE, 9, 1);
    if (row == null)
      throw new RuntimeException("row == null :(");
    // List<String> headers = Excel.getAll(row);
    Sheet sheet = Excel.getSheet();

    Map<String, String> mapFromExcel = createMap(sheet, 1, 173);

    File output = new File(PATH_TO_RESULT_FILE + "\\settingsdescriptions.properties");
    try (FileWriter fw = new FileWriter(output)) {
      for (String key : mapFromExcel.keySet()) {
        String str = key + "=" + mapFromExcel.get(key) + "\n";
        fw.write(str);
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
    System.out.println("END!!!");
  }

  private static Map<String, String> createMap(Sheet sheet, int fromRow, int toRow) {
    if (fromRow > toRow) {
      int temp = fromRow;
      fromRow = toRow;
      toRow = temp;
    }
    Map<String, String> map = new TreeMap<>();
    for (Row row : Excel.getRows(sheet)) {
      if (row.getRowNum() >= fromRow && row.getRowNum() <= toRow) {
        String key = Excel.get(row, 0);
        String value = Excel.get(row, 4).replaceAll("\n", " ");
        if (key.isEmpty()) continue;
        map.put(key, value);
      } else if (row.getRowNum() > toRow)
        break;
    }
    return map;
  }
}
