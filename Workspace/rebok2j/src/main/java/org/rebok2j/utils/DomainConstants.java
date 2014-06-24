package org.rebok2j.utils;

/**
 * Created by OrestO on 6/24/2014.
 */
public class DomainConstants {
    private static final String FIND_BY_NICKNAME_G = "findByNickName";
    private static final String FIND_ALL_G = "findAll";
    private static final String DELIMITER_CHARACTER = ".";

    public static class USER {
        private static final String ENTITY_NAME = "User";
        public static final String FIND_BY_NICKNAME = ENTITY_NAME + DELIMITER_CHARACTER + FIND_BY_NICKNAME_G;
        public static final String FIND_BY_NICKNAME_Q = "select entity from " + ENTITY_NAME + " entity where entity.userNickname = :nickname";
        public static final String FIND_ALL = ENTITY_NAME + DELIMITER_CHARACTER + FIND_ALL_G;
        public static final String FIND_ALL_Q = "select entity from " + USER.ENTITY_NAME + " entity";
    }

    public static class AUTHORIZATION {
        private static final String ENTITY_NAME = "Authorization";
        public static final String FIND_ALL = ENTITY_NAME + DELIMITER_CHARACTER + FIND_ALL_G;
        public static final String FIND_ALL_Q = "select entity from " + ENTITY_NAME + " entity";
    }

    public static class COURIER_COMPANY {
        private static final String ENTITY_NAME = "CourierCompany";
        public static final String FIND_ALL = ENTITY_NAME + DELIMITER_CHARACTER + FIND_ALL_G;
        public static final String FIND_ALL_Q = "select entity from " + ENTITY_NAME + " entity";

    }
}
