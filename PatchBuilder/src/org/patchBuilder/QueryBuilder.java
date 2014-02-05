package org.patchBuilder;

import java.io.File;
import java.util.List;
import java.util.Map;

public interface QueryBuilder {
    QueryBuilder build(Map<Integer, List<String>> map);

    QueryBuilder headerComment(String ticketCode, String Summary, String clientName, String Environments, int updatedRowCount, int runningTime);

    QueryBuilder now();

    QueryBuilder getClientIDForName(String name);

    QueryBuilder clear();

    File write2File(File output);

    @Override
    String toString();
}
