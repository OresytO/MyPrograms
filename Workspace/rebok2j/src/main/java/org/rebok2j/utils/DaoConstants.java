package org.rebok2j.utils;

/**
 * Created by OrestO on 6/23/2014.
 */
public enum DaoConstants {
    GET_RESULT_LIST("getResultList"), GET_SINGLE_RESULT("getSingleResult");

    String name;

    DaoConstants(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return this.name;
    }
}
