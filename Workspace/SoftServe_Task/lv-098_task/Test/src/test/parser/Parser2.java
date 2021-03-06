package test.parser;

import java.io.IOException;
import java.io.Reader;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import test.IpFactory;
import test.ip.IP;

public class Parser2 extends Parser {
	public Parser2() {
	}

	public Parser2(Reader r) {
		// super();
		char ch = 0;
		boolean endOfLine = true;
		StringBuilder buffer = new StringBuilder(40);
		try {
			while (true) {
				ch = (char) r.read();
				if (ch == -1 || ch == 65535) {
					if (buffer.length() > 0) {
						IP ip = IpFactory.getIP(buffer.toString());
						this.addToList(ip);
					}
					break;
				} else if (ch == '#') {
					endOfLine = false;
				} else if (ch == '\n') {
					endOfLine = true;
				} else if (ch == '\r' && buffer.length() > 0) {
					IP ip = IpFactory.getIP(buffer.toString());
					this.addToList(ip);
					buffer = new StringBuilder(40);
				} else if (endOfLine) {
					buffer.append(ch);
				}
			}
			r.close();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				r.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	public Parser2(Scanner s) {
		// super();
		Pattern pattern = Pattern
				.compile("(([0-9a-fA-F]+[.:]){3,7})[0-9a-fA-F]+");
		while (s.hasNext()) {
			StringBuilder buffer = new StringBuilder(20);
			Matcher matcher = pattern.matcher(s.nextLine());
			if (matcher.find()) {
				buffer.append(matcher.group());
				addToList(IpFactory.getIP(buffer.toString()));
			}

		}
		s.close();
	}
}
