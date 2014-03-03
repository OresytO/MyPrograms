package org;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import SAX.SAXHandler;

public class Runner {
    public static final String OUTPUT_FILE_PATH = "D:\\output\\RsultTest.xml";
    public static final String INPUT_FILE_PATH1 = "D:\\input\\Test.xml";

    public static void main(String[] args) {

        try {

            SAXParserFactory factory = SAXParserFactory.newInstance();
            SAXParser saxParser = factory.newSAXParser();

            DefaultHandler handler = new SAXHandler();

            saxParser.parse(INPUT_FILE_PATH1, handler);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
        
        
}
