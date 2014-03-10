package org.patchBuilder.templates;

import java.util.List;
import java.util.Map;

import org.patchBuilder.query.Oper;
import org.patchBuilder.query.Set;
import org.patchBuilder.query.Where;
import org.patchBuilder.utils.CONST;

public class QuestionFrenchFixQuery extends AbstractPatchQuery {

    // private static StringBuilder query;

    public QuestionFrenchFixQuery() {
        super();
    }

    public QuestionFrenchFixQuery(StringBuilder query) {
        super(query);
        QuestionFrenchFixQuery.query = query;
    }

    @Override
    public QuestionFrenchFixQuery build(Map<String, List<String>> map) {
        headerComment("PRR-8956", "Correct encoded french characters to the real ones on FB Q&A.", "samsung-fr_fr", "Production C4", 74, 60);
        now();
        getClientIDForName("samsung-fr_fr");

        List<String> list;
        for (String id : map.keySet()) {
            list = map.get(id);
            query.append("UPDATE Question q INNER JOIN QuestionVersion qv").append(CONST.EOL);
            query.append(CONST.TAB).append("ON q.QuestionVersionID = qv.ID").append(CONST.EOL);
            Set.begin("q.QuestionSummary", list.get(0));
            Set.add("q.QuestionDetails", list.get(1));
            Set.add("q.UserLocation", list.get(2));
            Set.add("q.LastUpdateTimestamp", "@currenttime");
            Set.add("qv.QuestionSummary", list.get(0));
            Set.add("qv.QuestionDetails", list.get(1));
            Set.add("qv.UserLocation", list.get(2));
            Set.add("qv.LastUpdateTimestamp", "@currenttime");
            query.append(Set.end());
            Where.begin("q.ID", Oper.EQU, id);
            Where.and("q.ClientID", Oper.EQU, "@cid");
            query.append(Where.end());
        }
        return this;
    }

    @Override
    public ReviewTagFixQuery build(Map<String, List<String>> tagMap, List<String> localeList) {
        new RuntimeException();
        return null;
    }
}