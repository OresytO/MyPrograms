package org.patchBuilder;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.patchBuilder.templates.AbstractPatchQuery;
import org.patchBuilder.templates.ReviewTagFixQuery;

public interface QueryBuilder {
    QueryBuilder build(Map<String, List<String>> map);

    QueryBuilder headerComment(String ticketCode, String Summary, String clientName, String Environments, int updatedRowCount, int runningTime);

    QueryBuilder now();

    QueryBuilder getClientIDForName(String name);

    QueryBuilder clear();

    File write2File(File output);

    @Override
    String toString();

    AbstractPatchQuery addNewVar(String varName, String varValue);

    ReviewTagFixQuery build(Map<String, List<String>> tagMap, List<String> localeList);
}
