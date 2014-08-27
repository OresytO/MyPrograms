import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

public class Excel {

    private static InputStream inp;
    private static Workbook wb;
    private static Sheet sheet;

    public static Workbook open(String fileName) throws InvalidFormatException {
        inp = null;
        try {
            inp = new FileInputStream(fileName);
            return WorkbookFactory.create(inp);
        } catch (IOException | InvalidFormatException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

    public static Sheet open(String fileName, int sheetNum) throws InvalidFormatException {
        inp = null;
        wb = null;
        try {
            inp = new FileInputStream(fileName);
            wb = WorkbookFactory.create(inp);
            return wb.getSheetAt(sheetNum);
        } catch (IOException | InvalidFormatException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

    public static Row open(String fileName, int sheetNum, int rowNum) throws InvalidFormatException {
        inp = null;
        wb = null;
        sheet = null;
        try {
            inp = new FileInputStream(fileName);
            wb = WorkbookFactory.create(inp);
            sheet = wb.getSheetAt(sheetNum);
            return sheet.getRow(rowNum);
        } catch (IOException | InvalidFormatException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

    public static String get(Row row, int cellNum) {
        Cell cell = row.getCell(cellNum);
        if (cell != null)
            return cell.getStringCellValue();
        else
            return null;
    }

    public static List<String> getAll(Row row) {
        List<String> list = new ArrayList<>();
        Iterator<Cell> cellIterator = row.cellIterator();
        while (cellIterator.hasNext()) {
            String str = cellIterator.next().getStringCellValue().replaceAll("\u00A0", "");
            list.add(str);
        }
        return list;
    }

    public static List<Row> getRows(Sheet sheet) {
        List<Row> list = new ArrayList<>();
        Iterator<Row> rowIterator = sheet.iterator();
        while (rowIterator.hasNext()) {
            list.add(rowIterator.next());
        }
        return list;
    }

    public static List<String> getAllFromColumn(Sheet sheet, int indexOfColumn) {
        List<String> list = new ArrayList<>();
        List<Row> rowList = getRows(Excel.getSheet());
        String str = "";
        for (int i = 1; i < rowList.size(); i++) {
            str = rowList.get(i).getCell(indexOfColumn).getStringCellValue();
            list.add(str);
        }
        list.remove(list.size() - 1);
        return list;
    }

    public static void close() {
        sheet = null;
        wb = null;
        try {
            inp.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    // ---------------------------------------------

    public static InputStream getInp() {
        return inp;
    }

    public static void setInp(InputStream inp) {
        Excel.inp = inp;
    }

    public static Workbook getWb() {
        return wb;
    }

    public static void setWb(Workbook wb) {
        Excel.wb = wb;
    }

    public static Sheet getSheet() {
        return sheet;
    }

    public static void setSheet(Sheet sheet) {
        Excel.sheet = sheet;
    }

}
