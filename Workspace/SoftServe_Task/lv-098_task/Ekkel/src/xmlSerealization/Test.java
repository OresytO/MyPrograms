/**
 * 
 */
package xmlSerealization;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

/**
 * @author OrestO
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name = "Test")
@XmlType(propOrder = { "pubStr", "pubI", "privStr", "privStatInt", "privStatFinI" })
public class Test {
	@XmlElement(required = true)
	public String pubStr;
	@XmlElement(required = true)
	public int pubI;
	@XmlElement(required = true)
	private String privStr;
	@XmlElement(required = true)
	private static int privStatInt;
	@XmlElement(required = true)
	private static final int privStatFinI = 10;

	Test() {

	}

	/**
	 * @param pubStr
	 * @param pubI
	 * @param privStr
	 */
	public Test(String pubStr, int pubI, String privStr) {
		super();
		this.pubStr = pubStr;
		this.pubI = pubI;
		this.privStr = privStr;
	}

	public String getPubStr() {
		return pubStr;
	}

	public void setPubStr(String pubStr) {
		this.pubStr = pubStr;
	}

	public int getPubI() {
		return pubI;
	}

	public void setPubI(int pubI) {
		this.pubI = pubI;
	}

	public String getPrivStr() {
		return privStr;
	}

	public void setPrivStr(String privStr) {
		this.privStr = privStr;
	}

	public static int getPrivStatInt() {
		return privStatInt;
	}

	public static void setPrivStatInt(int privStatInt) {
		Test.privStatInt = privStatInt;
	}

	public static int getPrivstatfini() {
		return privStatFinI;
	}
}


