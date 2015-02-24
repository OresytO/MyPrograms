package org.tasks;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.patchBuilder.Xml.impl.ParserImpl;
import org.patchBuilder.templates.AnswerFrenchFixQuery;
import org.patchBuilder.templates.QuestionFrenchFixQuery;

public class PRR_8956 {

    public static final String INPUT_FILE_PATH1 = "D:\\input\\result-c4-temp1.xml";
    public static final String INPUT_FILE_PATH2 = "D:\\input\\result-c4-temp2.xml";
    public static final String OUTPUT_FILE_PATH = "D:\\output\\PRR_8956.sql";

    public static void main(String[] args) throws IOException {
        Map<String, List<String>> map = new HashMap<>();
        StringBuilder string = new StringBuilder();

        QuestionFrenchFixQuery question = new QuestionFrenchFixQuery(string);
        AnswerFrenchFixQuery answer = new AnswerFrenchFixQuery(string);
        List<String> heading = new ArrayList<>();
        heading.add("ID");
        heading.add("QuestionSummary");
        heading.add("QuestionDetails");
        heading.add("UserLocation");

        File output = new File(OUTPUT_FILE_PATH);

        map = new ParserImpl().parse(INPUT_FILE_PATH1, heading);
        question.build(map);

        heading.clear();
        heading.add("ID");
        heading.add("AnswerText");

        map = new ParserImpl().parse(INPUT_FILE_PATH2, heading);
        answer.build(map);

        question.write2File(output);

    }

}
