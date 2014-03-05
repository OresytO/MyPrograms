package org.patchBuilder.templates;

import java.util.List;
import java.util.Map;

import org.patchBuilder.query.Oper;
import org.patchBuilder.query.Set;
import org.patchBuilder.query.Where;
import org.patchBuilder.utils.CONST;

public class ReviewTagFixQuery extends AbstractPatchQuery {

    // protected static StringBuilder query;

    public ReviewTagFixQuery() {
        super();
    }

    public ReviewTagFixQuery(StringBuilder query) {
        super(query);
        this.query = query;
    }

    @Override
    public ReviewTagFixQuery build(Map<String, List<String>> map) {
        headerComment("PRR-9710", "Starwood: tags update (DB Patch)", "Starwood", "Nightly Production C6", 74, 60);
        getClientIDForName("Starwood");
        /*SELECT * FROM ReviewVersion rv 
        JOIN ReviewTag rt ON rv.ID = rt.ReviewVersionID AND rv.ClientID = @CID
        JOIN Tag t ON rt.TagID = t.ID AND t.Label = @OLD_TAG
        JOIN   (SELECT  id, 
            CASE `label` 
                WHEN 'Nähe zum Flughafen' THEN 'de_DE'  
                WHEN 'Proximité de l''aéroport' THEN 'fr_FR'  
                WHEN 'Cercanía al aeropuerto' THEN 'es_UN' 
                WHEN 'Vicinanza all\'aeroporto' THEN 'it_IT' 
                WHEN 'Proximidade ao aeroporto' THEN 'pt_BR' 
                WHEN '空港から近い' THEN 'ja_JP' 
                WHEN '毗邻机场' THEN 'zh_CN' 
                WHEN 'Близость к аэропорту' THEN 'ru_RU' 
                WHEN '공항 근접'THEN 'ko_KR' 
                WHEN '靠近機場' THEN 'zh_TW' 
                WHEN 'موقعه القريب من المطار' THEN 'ar_AE'           
            END AS locale
        FROM  Tag
        WHERE clientid=118 AND label IN ('Nähe zum Flughafen', 'Proximité de l''aéroport', 'Cercanía al aeropuerto', 'Vicinanza all\'aeroporto', 'Proximidade ao aeroporto', '空港から近い', '毗邻机场', 'Близость к аэропорту', '공항 근접', '靠近機場', 'موقعه القريب من المطار') ) temp ON temp.locale = rv.DisplayLocale
        WHERE rt.TagID = (SELECT ID FROM Tag WHERE ClientID = @CID AND Label = @OLD_TAG);*/
        List<String> list;
        for (String old_tag : map.keySet()) {
            addNewVar("old_tag", old_tag);
            list = map.get(old_tag);
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

}
