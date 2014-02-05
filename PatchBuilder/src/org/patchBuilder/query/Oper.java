package org.patchBuilder.query;

//public abstract class Oper {
//    public static final String EQU = " = ";
//    public static final String GT = " > ";
//    public static final String LT = " < ";
//    public static final String GET = " >= ";
//    public static final String LET = " <= ";
//    public static final String NEQ = " <> ";
//    public static final String IN = " IN (";
//    public static final String NIN = " NOT IN (";
//    public static final String LK = " LIKE ";
//    public static final String NLK = " NOT LIKE ";
//
//    private Oper() {
//    }
//}

public enum Oper {
    EQU(" = "), GT(" > "), LT(" < "), GET(" >= "), LET(" <= "), NEQ(" <> "), IN(" IN ("), NIN(" NOT IN ("), LK(" LIKE "), NLK(" NOT LIKE ");

    String str;

    Oper(String str) {
        this.str = str;
    }

    @Override
    public String toString() {
        return str;
    }
}
