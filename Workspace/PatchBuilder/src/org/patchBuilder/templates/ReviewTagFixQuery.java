package org.patchBuilder.templates;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.patchBuilder.query.CreateTable;
import org.patchBuilder.query.Insert;
import org.patchBuilder.query.Oper;
import org.patchBuilder.query.Where;
import org.patchBuilder.utils.CONST;

public class ReviewTagFixQuery extends AbstractPatchQuery {

    // protected static StringBuilder query;

    public ReviewTagFixQuery() {
        super();
    }

    public ReviewTagFixQuery(StringBuilder query) {
        super(query);
        ReviewTagFixQuery.query = query;
    }

    @Override
    public ReviewTagFixQuery build(Map<String, List<String>> tagMap, List<String> localeList) {
        headerComment("PRR-9710", "Starwood: tags update (DB Patch)", "Starwood", "Nightly Production C6", 74, 60);
        getClientIDForName("Starwood");

        String tableName = "IncommingMapping";
        CreateTable.begin(tableName, "ClientID varchar(255) NOT NULL");
        CreateTable.add("DimensionExternalID varchar(255) NOT NULL");
        CreateTable.add("Label varchar(255) NOT NULL");
        query.append(CreateTable.end());

        List<String> dimensionExternalID = new ArrayList<>();
        dimensionExternalID.add("Pro");
        dimensionExternalID.add("Con");
        dimensionExternalID.add("Impression");

        Insert.begin(tableName, "ClientID, DimensionExternalID, Label", null);
        Set<String> set = new HashSet<>();
        StringBuilder temp = new StringBuilder();
        for (String tag : tagMap.keySet())
            for (String tagStr : tagMap.get(tag))
                for (String dimID : dimensionExternalID) {
                    temp.delete(0, temp.length());
                    if (set.add(dimID + " " + tagStr))
                        Insert.add(temp.append("@CID, ").append(CONST.QUO).append(dimID).append(CONST.QUO).append(", ").append(CONST.QUO).append(tagStr)
                                .append(CONST.QUO));
                }
        query.append(Insert.end());

        // tableName = "ExictingTag";
        // CreateTable.begin(tableName, "AS SELECT ClientID, DimensionExternalID, Label FROM Tag Where ClientID = @CID");
        // query.append(CreateTable.end());
        //
        // tableName = "Tag";

        query.append("INSERT INTO Tag (ClientID, DimensionExternalID, Label)").append(CONST.EOL);
        query.append("SELECT ClientID, DimensionExternalID, Label").append(CONST.EOL);
        query.append("FROM IncommingMapping ").append(CONST.EOL);
        query.append("WHERE (DimensionExternalID, Label) NOT IN (").append(CONST.EOL);
        query.append(CONST.TAB).append("SELECT DimensionExternalID, Label FROM Tag WHERE ClientID = @CID").append(CONST.EOL);
        query.append(");").append(CONST.EOL).append(CONST.EOL);

        query.append("DROP TABLE IF EXISTS IncommingMapping;").append(CONST.EOL);

        List<String> list;
        for (String tag : tagMap.keySet()) {
            list = tagMap.get(tag);
            addNewVar("old_tag", CONST.QUO + tag + CONST.QUO);
            query.append("UPDATE ReviewVersion rv").append(CONST.EOL);
            query.append("JOIN ReviewTag rt ON rv.ID = rt.ReviewVersionID AND rv.ClientID = @CID").append(CONST.EOL);
            query.append("JOIN Tag t ON rt.TagID = t.ID AND t.Label = @OLD_TAG").append(CONST.EOL);
            query.append("JOIN (SELECT id, DimensionExternalID, ").append(CONST.EOL);
            query.append(CONST.TAB).append("CASE label").append(CONST.EOL);
            for (int i = 0; i < list.size(); i++)
                query.append(CONST.TAB2).append("WHEN ").append(CONST.QUO).append(list.get(i)).append(CONST.QUO).append(" THEN '").append(localeList.get(i))
                        .append("'").append(CONST.EOL);
            query.append(CONST.TAB).append("END AS locale").append(CONST.EOL);
            query.append("FROM  Tag").append(CONST.EOL);
            query.append("WHERE ClientID = @CID AND label IN (");
            for (String str : list)
                query.append(CONST.QUO).append(str).append(CONST.QUO).append(", ");
            query.delete(query.length() - 2, query.length());
            query.append(")) temp ON temp.locale = rv.DisplayLocale").append(CONST.EOL);
            query.append("SET rt.TagID = temp.ID").append(CONST.EOL);
            Where.begin("rt.TagID", Oper.EQU,
                    "(SELECT ID FROM Tag WHERE ClientID = @CID AND Label = @OLD_TAG  AND DimensionExternalID = temp.DimensionExternalID)");
            query.append(Where.end()).append(CONST.EOL);
        }
        return this;
    }

    @Override
    public AbstractPatchQuery build(Map<String, List<String>> map) {
        new RuntimeException();
        return null;
    }

}
