package org.rebok2j.utils;

/**
 * Created by OrestO on 6/23/2014.
 */
public enum ModelConstants {
    AUTHORIZATION("AUTHORIZATION"), COURIER_COMPANY("COURIER_COMPANY"), DELIVERY("DELIVERY"), DELIVERY_TYPE("DELIVERY_TYPE"), ID_TYPE("ID_TYPE"),
    LOCATION("LOCATION");

    String name;

    ModelConstants(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return this.name;
    }
}
