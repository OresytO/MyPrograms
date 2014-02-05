/**
 * 
 */
package xmlSerealization;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

/**
 * @author orecto
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = { "test" })
@XmlRootElement(name = "priceList")
public class PriceList {
	@XmlElement(required = true)
	public List<Test> test;

	//
	public List<Test> getTest() {
		if (test == null) {
			test = new ArrayList<Test>();
		}
		return this.test;
	}

	public void setTest(List<Test> test) {
		test = this.test;
	}

}
