package test;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

import test.parser.Parser;
import test.parser.Parser1;
import test.parser.Parser2;
import test.parser.Parser3;

public class ParserFactory {
	public static Parser getParser(String sourceName) {
		if (sourceName == null) {
			throw new RuntimeException("getParser() get null as parameter");
		} else {
			if (sourceName.isEmpty())
				throw new RuntimeException("getParser() get empty parameter");
			else {
				File f = new File(sourceName);
				BufferedReader br = null;
				try {
					br = new BufferedReader(new FileReader(f));
					if (f.getName().equals(Config.res1))
						return new Parser1(br);
					else if (f.getName().equals(Config.res2))
						return new Parser2(br);
					else if (f.getName().equals(Config.res3))
						return new Parser3(br);
					else {
						throw new RuntimeException(
								"getParser() get parameter with unknown format");
					}
				} catch (IOException e) {
					e.printStackTrace();
				} finally {
					try {
						br.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				throw new RuntimeException(
						"getParser() unknown Exception");
			}
		}
	}
}
