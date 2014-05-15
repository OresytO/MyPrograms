package org.patchBuilder.utils;


public class Validator {
    public static boolean isNull(String value) {
        return (value == null || value.equals(CONST.NULL));
    }

    public static boolean isNotNull(String value) {
        return !isNull(value);
    }
}
