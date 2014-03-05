package org.tickets;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Row;
import org.patchBuilder.msOffice.Excel;
import org.patchBuilder.templates.ReviewTagFixQuery;

public class PRR_9710 {
    public static final String INPUT_FILE_PATH = "D:\\input\\starwood_tags_locale_mapping.xlsx";
    public static final String OUTPUT_FILE_PATH = "D:\\output\\PRR_9710.sql";

    public static void main(String[] args) {

        // ------getting infomation from file-------- //
        Row row = Excel.open(INPUT_FILE_PATH, 0, 0);
        if (row == null)
            throw new RuntimeException("row == null :(");
        System.out.println(Excel.get(row, 1));

        List<String> localeList = Excel.getAll(row);
        System.out.println(localeList);

        List<String> tagList = Excel.getAllFromColumn(Excel.getSheet(), 0);
        System.out.println(tagList);

        Map<String, List<String>> map = createMap();

        // --------------building Query-------------- //
        ReviewTagFixQuery query = new ReviewTagFixQuery();

        query.build(map);

        query.write2File(new File(OUTPUT_FILE_PATH));
    }

    private static Map<String, List<String>> createMap() {
        HashMap<String, List<String>> map = new HashMap<>();

        return map;
    }
}
