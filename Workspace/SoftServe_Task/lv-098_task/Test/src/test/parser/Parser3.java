package test.parser;

import java.io.IOException;
import java.io.Reader;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import test.IpFactory;
import test.ip.IP;

public class Parser3 extends Parser {
	public Parser3() {
	}

	public Parser3(Reader r) {
		// super();
		char ch = 0;
		boolean read = false;
		StringBuilder buffer = new StringBuilder(40);
		try {
			while (true) {
				ch = (char) r.read();
				if (ch == -1 || ch == 65535) {
					break;
				} else if (ch == ' ') {
					read = true;
				} else if (ch == '\t' && buffer.length() > 0) {
					IP ip = IpFactory.getIP(buffer.toString());
					this.addToList(ip);
					buffer = new StringBuilder(40);
					read = false;
				} else if (read) {
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

	public Parser3(Scanner s) {
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
