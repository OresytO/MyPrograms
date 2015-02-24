package org.patchBuilder.query;

import org.patchBuilder.utils.CONST;

public class Where {
    private static StringBuilder temp = new StringBuilder();
    private static StringBuilder query = new StringBuilder();
    private static int expCount = 0;

    // public Set(StringBuilder query) {
    // this.query = query;
    // }

    public static void begin(String field, Oper operation, Object value) {
        if (expCount >= 1)
            throw new IllegalArgumentException("You must end previose Where block before begin. You can't begin one block twice!!!");
        temp = new StringBuilder();
        query = new StringBuilder();
        query.append("WHERE ");
        if (operation.equals(Oper.IN) || operation.equals(Oper.NIN)) {
            temp.append(field).append(operation).append(value).append(")").append(CONST.EOL);
        } else {
            temp.append(field).append(operation).append(value).append(CONST.EOL);
        }
        query.append(temp);
        expCount = 1;
    }

    public static StringBuilder end() {
        expCount = 0;
        query.delete(query.length() - 2, query.length());
        query.append(";").append(CONST.EOL).append(CONST.EOL);
        // query.delete(0, query.length());
        return query;
    }

    public static void and(String field, Oper operation, Object value) {
        // temp.delete(0, temp.length());
        query.append(CONST.TAB).append("AND ");
        if (operation.equals(Oper.IN) || operation.equals(Oper.NIN)) {
            query.append(field).append(operation).append(value).append(")").append(CONST.EOL);
        } else {
            query.append(field).append(operation).append(value).append(CONST.EOL);
        }
        // query.append(temp);
        expCount++;
    }

    public static void or(String field, Oper operation, Object value) {
        temp = new StringBuilder();
        query.append(CONST.TAB).append("OR ");
        if (operation.equals(Oper.IN) || operation.equals(Oper.NIN)) {
            temp.append(field).append(operation).append(value).append(")").append(CONST.EOL);
        } else {
            temp.append(field).append(operation).append(value).append(CONST.EOL);
        }
        query.append(temp);
        expCount++;
    }
}
