package org.patchBuilder.templates;

import java.util.List;
import java.util.Map;

import org.patchBuilder.query.Oper;
import org.patchBuilder.query.Set;
import org.patchBuilder.query.Where;
import org.patchBuilder.utils.CONST;

public class AnswerFrenchFixQuery extends AbstractPatchQuery {

    // protected static StringBuilder query;

    public AnswerFrenchFixQuery() {
        super();
    }

    public AnswerFrenchFixQuery(StringBuilder query) {
        super(query);
        this.query = query;
    }

    @Override
    public AnswerFrenchFixQuery build(Map<String, List<String>> map) {
        List<String> list;
        for (String id : map.keySet()) {
            list = map.get(id);
            query.append("UPDATE Answer a INNER JOIN AnswerVersion av").append(CONST.EOL);
            query.append(CONST.TAB).append("ON a.AnswerVersionID = av.ID").append(CONST.EOL);
            Set.begin("a.AnswerText", list.get(0));
            Set.add("a.LastUpdateTimestamp", "@currenttime");
            Set.add("av.AnswerText ", list.get(0));
            Set.add("a.LastUpdateTimestamp", "@currenttime");
            query.append(Set.end());
            Where.begin("a.ID", Oper.EQU, id);
            Where.and("q.ClientID", Oper.EQU, "@cid");
            query.append(Where.end());
        }
        return this;
    }
}