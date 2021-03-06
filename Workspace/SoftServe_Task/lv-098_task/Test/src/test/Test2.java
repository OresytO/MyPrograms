package test;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Date;
import java.util.Scanner;

import test.parser.Parser3;

public class Test2 {
	public static void main(String[] args) {
		Date start = null;
		Date end = null;
		File f = new File("C:\\Users\\orecto\\Desktop\\res3.txt");
		Scanner scanner = null;
		FileReader fReader = null;
		BufferedReader bReader = null;
		Parser3 p1 = null;
		Parser3 p2 = null;
		Parser3 p3 = null;

		// Scanner
		try {
			scanner = new Scanner(f);
			start = new Date();
			p1 = new Parser3(scanner);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		end = new Date();
		System.out.println("IPv4: " + p1.getListIPv4().size());
		System.out.println("IPv6: " + p1.getListIPv6().size());
		System.out.println("duration Scanner "
				+ (end.getTime() - start.getTime()) + " ms\n");
		scanner.close();

		// FileReader
		try {
			fReader = new FileReader(f);
			start = new Date();
			p2 = new Parser3(fReader);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		end = new Date();
		System.out.println("IPv4: " + p2.getListIPv4().size());
		System.out.println("IPv6: " + p2.getListIPv6().size());
		System.out.println("duration FileReader "
				+ (end.getTime() - start.getTime()) + " ms\n");
		try {
			fReader.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		// BufferedReader(FileReader)
		try {
			fReader = new FileReader(f);
			bReader = new BufferedReader(fReader);
			start = new Date();
			p3 = new Parser3(bReader);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		end = new Date();
		System.out.println("IPv4: " + p3.getListIPv4().size());
		System.out.println("IPv6: " + p3.getListIPv6().size());
		System.out.println("duration BufferedReader(FileReader) "
				+ (end.getTime() - start.getTime()) + " ms\n");
		try {
			bReader.close();
			fReader.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
}
