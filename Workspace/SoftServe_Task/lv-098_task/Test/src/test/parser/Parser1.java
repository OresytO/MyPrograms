package test.parser;

import java.io.IOException;
import java.io.Reader;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import test.IpFactory;
import test.ip.IP;

public class Parser1 extends Parser {
	public Parser1() {
	}

	public Parser1(Reader r) {
		// super();
		char ch = 0;
		int count = 0;
		boolean readed = false;
		boolean endOfLine = true;
		StringBuilder buffer = new StringBuilder(40);
		try {
			while (true) {
				ch = (char) r.read();
				if (((int) ch) == -1) {
					break;
				} else if ((ch == '/' || ch == ' ') && !readed) {
					IP ip = IpFactory.getIP(buffer.toString());
					this.addToList(ip);
					readed = true;
				} else if (ch == '\n') {
					buffer = new StringBuilder(40);
					endOfLine = true;
				} else if (ch != ' ' && endOfLine) {
					buffer.append(ch);
					readed = false;
					endOfLine = false;
					count = 0;
				} else if (!endOfLine && !readed) {
					buffer.append(ch);
					readed = false;
				} else if (endOfLine && count < 8) {
					count++;
				} else if (count >= 8) {
					break;
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

	public Parser1(Scanner s) {
		// super();
		Pattern pattern = Pattern
				.compile("(([0-9a-fA-F]+[.:]){3,7})[0-9a-fA-F]+");
		while (s.hasNext()) {
			Matcher matcher = pattern.matcher(s.nextLine());
			if (matcher.find()) {
				addToList(IpFactory.getIP(matcher.group()));
			}
		}
		s.close();
	}
}
