package test;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name = "CONSTANTS")
@XmlType(propOrder = { "res1", "RES2", "RES3", "SOURCE_DESTINATION" })
public class Config {
	@XmlElement(required = true)
	public static String res1 = "res1.txt";
	@XmlElement(required = true)
	public static String res2 = "res2.txt";
	@XmlElement(required = true)
	public static String res3 = "res3.txt";

	@XmlElement(required = true)
	public static String[] sourceDestination = {
			"C:\\Users\\orecto\\Desktop\\res1.txt",
			"C:\\Users\\orecto\\Desktop\\res2.txt",
			"C:\\Users\\orecto\\Desktop\\res3.txt" };

	public Config() {

	}

	public static String getRes1() {
		return res1;
	}

	public static String getRes2() {
		return res2;
	}

	public static String getRes3() {
		return res3;
	}

	public static String[] getSourceDestination() {
		return sourceDestination;
	}

}
