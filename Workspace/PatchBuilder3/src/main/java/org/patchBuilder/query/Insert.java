package org.patchBuilder.query;

import java.util.List;

import org.patchBuilder.utils.CONST;
import org.patchBuilder.utils.Validator;

public class Insert {
    private static StringBuilder query = new StringBuilder();
    private static StringBuilder fieldValues = new StringBuilder();
    private static int expCount = 0;

    public static void begin(String tableName, String fieldNames, String values) {
        if (expCount >= 1)
            throw new IllegalArgumentException("You must end previouse Insert block before begin. You can't begin one block twice!!!");
        if (tableName == null || tableName.isEmpty() || Validator.isNull(tableName))
            throw new IllegalArgumentException("You can't insert into table without name!!!");
        query = new StringBuilder();
        query.append("INSERT INTO ").append(tableName).append(" (");
        if (fieldNames == null || fieldNames.isEmpty() || fieldNames.contains("NULL"))
            throw new IllegalArgumentException("You can't insert without field name!!!");
        query.append(fieldNames);
        // query.append(") VALUES (");
        expCount = 1;
        if (values != null)
            add(new StringBuilder(values));
    }

    public static void addAll(List<StringBuilder> valuesList) {
        for (StringBuilder fieldValue : valuesList) {
            fieldValues.append(CONST.EOL);
            add(fieldValue);
        }
    }

    public static void add(StringBuilder values) {
        if (!(expCount >= 1))
            throw new IllegalArgumentException("You can't add into insert block before you begin it!!!");
        if (values == null || values.length() <= 0)
            throw new IllegalArgumentException("You can't insert into table list without values!!!");
        fieldValues.append(expCount > 1 ? CONST.TAB : "").append("(").append(values).append("), ").append(CONST.EOL);
        expCount++;
    }

    public static StringBuilder end() {
        expCount = 0;
        fieldValues.delete(fieldValues.length() - 4, fieldValues.length());
        query.append(")").append(CONST.EOL).append("VALUES ").append(fieldValues).append(";").append(CONST.EOL).append(CONST.EOL);
        return query;
    }
}
