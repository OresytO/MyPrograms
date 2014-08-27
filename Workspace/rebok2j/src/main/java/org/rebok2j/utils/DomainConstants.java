package org.rebok2j.utils;

/**
 * Created by OrestO
 * on 6/24/2014.
 */
public final class DomainConstants {
  public static final String FIND_BY_NICKNAME_G = "findByNickName";
  public static final String FIND_ALL_G = "findAll";
  public static final String DELIMITER_CHARACTER = ".";

  public static final class USER {
    // Entity name
    public static final String ENTITY_NAME = "User";
    // Params for Query
    public static final String NICKNAME = "nickname";
    // Queries name
    public static final String FIND_BY_NICKNAME = ENTITY_NAME + DELIMITER_CHARACTER + FIND_BY_NICKNAME_G;
    public static final String FIND_ALL = ENTITY_NAME + DELIMITER_CHARACTER + FIND_ALL_G;
    // Queries
    public static final String FIND_BY_NICKNAME_Q = "select entity from " + ENTITY_NAME + " entity where entity.userNickname = :" + NICKNAME;
    public static final String FIND_ALL_Q = "select entity from " + USER.ENTITY_NAME + " entity";
  }

  public static final class AUTHORIZATION {
    // Entity name
    public static final String ENTITY_NAME = "Authorization";
    // Queries name
    public static final String FIND_ALL = ENTITY_NAME + DELIMITER_CHARACTER + FIND_ALL_G;
    // Queries
    public static final String FIND_ALL_Q = "select entity from " + ENTITY_NAME + " entity";
  }

  public static final class COURIER_COMPANY {
    // Entity name
    public static final String ENTITY_NAME = "CourierCompany";
    // Queries name
    public static final String FIND_ALL = ENTITY_NAME + DELIMITER_CHARACTER + FIND_ALL_G;
    // Queries
    public static final String FIND_ALL_Q = "select entity from " + ENTITY_NAME + " entity";
  }

  public static final class DELIVERY {
    // Entity name
    public static final String ENTITY_NAME = "Delivery";
    // Queries name
    public static final String FIND_ALL = ENTITY_NAME + DELIMITER_CHARACTER + FIND_ALL_G;
    // Queries
    public static final String FIND_ALL_Q = "select entity from " + ENTITY_NAME + " entity";
  }

  public static final class DELIVERY_TYPE {
    // Entity name
    public static final String ENTITY_NAME = "DeliveryType";
    public static final String ENTITY_NAME_FIELD = "deliveryType";
    // Queries name
    public static final String FIND_ALL = ENTITY_NAME + DELIMITER_CHARACTER + FIND_ALL_G;
    // Queries
    public static final String FIND_ALL_Q = "select entity from " + ENTITY_NAME + " entity";
  }

  public static final class ID_TYPE {
    // Entity name
    public static final String ENTITY_NAME = "IdType";
    // Queries name
    public static final String FIND_ALL = ENTITY_NAME + DELIMITER_CHARACTER + FIND_ALL_G;
    // Queries
    public static final String FIND_ALL_Q = "select entity from " + ENTITY_NAME + " entity";
  }

  public static final class LOCATION {
    // Entity name
    public static final String ENTITY_NAME = "Location";
    // Queries name
    public static final String FIND_ALL = ENTITY_NAME + DELIMITER_CHARACTER + FIND_ALL_G;
    // Queries
    public static final String FIND_ALL_Q = "select entity from " + ENTITY_NAME + " entity";
  }

  public static final class STAFF {
    // Entity name
    public static final String ENTITY_NAME = "Staff";
    // Queries name
    public static final String FIND_ALL = ENTITY_NAME + DELIMITER_CHARACTER + FIND_ALL_G;
    // Queries
    public static final String FIND_ALL_Q = "select entity from " + ENTITY_NAME + " entity";
  }

  private DomainConstants() {
    throw new IllegalAccessError("do not try to create instance of DomainConstants");
  }
}
