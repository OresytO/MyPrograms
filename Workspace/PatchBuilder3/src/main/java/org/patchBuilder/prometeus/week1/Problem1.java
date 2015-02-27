package org.patchBuilder.prometeus.week1;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

/**
 * Created by OrestO
 * on 2/24/2015.
 */
public class Problem1
{
    public static void main(String ... args) throws IOException {
        //String filePath = "InputForAlgo/Week1Problem1.txt";
        //List<ParseResult> parseResult = InputDataParser.parse(Thread.currentThread().getContextClassLoader().getResource(filePath).openStream());
        String filePath = "D:\\MyPrograms\\Workspace\\PatchBuilder3\\src\\main\\java\\InputForAlgo\\Week1Problem1.txt";
        List<ParseResult> parseResult = InputDataParser.parse(new FileInputStream(filePath));
        System.out.println(parseResult.get(0).getCounterMap());
    }
}
