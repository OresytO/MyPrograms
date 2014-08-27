package runner;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;

import classes.Excel;

public class RunnerMain {

    public static final String INPUT_FILE_PATH1 = "C:\\Users\\olozyn\\Desktop\\Copy of R-IT-Chcklst.xls-revHEAD.svn000.tmp.xls";
    public static final String INPUT_FILE_PATH2 = "D:\\working\\3.6.0\\Trunk\\blue-web\\schawk-parts-web\\src\\resources\\settingsdescriptions.properties";
    public static final String OUTPUT_FILE_PATH = "D:\\output\\settingsdescriptions.properties";

    public static void main(String[] args) {
        System.out.println("BEGIN!!!");
        // ------getting infomation from file-------- //
        // Row row = Excel.open(INPUT_FILE_PATH1, 10, 1);
        // if (row == null)
        // throw new RuntimeException("row == null :(");
        // List<String> headers = Excel.getAll(row);
        Map<String, String> mapFromExcel = createMap(Excel.getSheet(), 1, 174);

        File output = new File(OUTPUT_FILE_PATH);
        try (FileWriter fw = new FileWriter(output)) {
            for (String key : mapFromExcel.keySet())
                fw.write(key + "=" + mapFromExcel.get(key));
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
        HashMap<String, String> map = new HashMap<>();
        for (Row row : Excel.getRows(sheet)) {
            if (row.getRowNum() >= fromRow && row.getRowNum() <= toRow) {
                map.put(Excel.get(row, 1), Excel.get(row, 5));
            } else if (row.getRowNum() > toRow)
                break;
        }
        return map;
    }
}
