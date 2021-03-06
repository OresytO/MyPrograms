/**
 * 
 */
package xmlSerealization;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

/**
 * @author orecto
 * 
 */
public class XmlSerealization {
	public static void main(String[] args) {
		try {
			PriceList priceList = new PriceList();
			// for (int i = 0; i < 10; i++) {
			// Test t = new Test();
			// t.setPubI(i);
			// priceList.getTest().add(t);
			// }
			// File file = new File("work.xml");
			// JAXBContext context1 = JAXBContext.newInstance(PriceList.class);
			// Marshaller m = context1.createMarshaller();
			// m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
			// m.marshal(priceList, System.out);
			// m.marshal(priceList, file);
			// System.out.println();

			FileInputStream fis = new FileInputStream("work.xml");
			JAXBContext context2 = JAXBContext.newInstance(PriceList.class);
			Unmarshaller um = context2.createUnmarshaller();
			PriceList pl = (PriceList) context2.createUnmarshaller().unmarshal(fis);
			
			for (int i = 0; i < pl.test.size(); i++) {
				Test c = pl.test.get(i);
				System.out.println("pubI=" + c.pubI + " pubStr" + c.pubStr
						+ " getPrivStr()=" + c.getPrivStr()
						+ " getPrivstatfini()=" + c.getPrivstatfini()
						+ " getPrivStatInt()=" + c.getPrivStatInt());
			}
		} catch (JAXBException e) {
			System.out.println("JAXBException" + e);
		} catch (FileNotFoundException e) {
			System.out.println("FileNotFoundException" + e);
		}// try

	}
}
