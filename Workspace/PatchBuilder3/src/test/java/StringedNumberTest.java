import org.junit.Test;
import org.patchBuilder.prometeus.week1.StringedNumber;

import java.io.IOException;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

/**
 * @author olozynskyy
 * @since 3.7.0
 */
public class StringedNumberTest
{

  @Test
  public void splitTest()
  {
    StringedNumber stringedNumber = new StringedNumber("12345678");

    assertEquals(2, stringedNumber.split(2).size());
    assertEquals(3, stringedNumber.split(3).size());
    assertEquals(4, stringedNumber.split(4).size());
    assertEquals(5, stringedNumber.split(5).size());
  }

  @Test
  public void compareToTest()
  {
    assertTrue(new StringedNumber("123").compareTo(new StringedNumber("123")) == 0);
    assertTrue(new StringedNumber("-123").compareTo(new StringedNumber("-123")) == 0);
    assertTrue(new StringedNumber("0").compareTo(new StringedNumber("0")) == 0);

    assertTrue(new StringedNumber("123").compareTo(new StringedNumber("122")) > 0);
    assertTrue(new StringedNumber("-122").compareTo(new StringedNumber("-123")) > 0);
    assertTrue(new StringedNumber("122").compareTo(new StringedNumber("-123")) > 0);

    assertTrue(new StringedNumber("122").compareTo(new StringedNumber("123")) < 0);
    assertTrue(new StringedNumber("-123").compareTo(new StringedNumber("-122")) < 0);
    assertTrue(new StringedNumber("-123").compareTo(new StringedNumber("122")) < 0);
  }

  @Test
  public void testAddition()
  {
    assertEquals("579", new StringedNumber("123").add(new StringedNumber("456")).toString());
    assertEquals("-2", new StringedNumber("-5").add(new StringedNumber("3")).toString());
    assertEquals("2", new StringedNumber("5").add(new StringedNumber("-3")).toString());
    assertEquals("-8", new StringedNumber("-5").add(new StringedNumber("-3")).toString());
    assertEquals("1122", new StringedNumber("123").add(new StringedNumber("999")).toString());
    assertEquals(
        "57900000000000000000000000000000000000000000000000000000000000000000000000000000000",
        new StringedNumber("12300000000000000000000000000000000000000000000000000000000000000000000000000000000").add(
            new StringedNumber("45600000000000000000000000000000000000000000000000000000000000000000000000000000000")).toString());

    assertEquals("120", new StringedNumber("123").add(new StringedNumber("-3")).toString());
    assertEquals("-200", new StringedNumber("100").add(new StringedNumber("-300")).toString());
    assertEquals("2200000", new StringedNumber("2200000").add(new StringedNumber("0")).toString());
    assertEquals("220000", new StringedNumber("200000").add(new StringedNumber("20000")).toString());
  }

  @Test
  public void testPow()
  {
    assertEquals("1", StringedNumber.powOfTen(0).toString());
    assertEquals("10", StringedNumber.powOfTen(1).toString());
    assertEquals("100000", StringedNumber.powOfTen(5).toString());
    assertEquals("1000000000000000", StringedNumber.powOfTen(15).toString());
  }

  @Test
  public void testSubstration()
  {
    assertEquals("2", new StringedNumber("5").subtraction(new StringedNumber("3")).toString());
    assertEquals("-2", new StringedNumber("3").subtraction(new StringedNumber("5")).toString());
    assertEquals("-8", new StringedNumber("-5").subtraction(new StringedNumber("3")).toString());
    assertEquals("-8", new StringedNumber("-3").subtraction(new StringedNumber("5")).toString());
    assertEquals("-2", new StringedNumber("-5").subtraction(new StringedNumber("-3")).toString());
    assertEquals("2", new StringedNumber("-3").subtraction(new StringedNumber("-5")).toString());
    assertEquals("8", new StringedNumber("5").subtraction(new StringedNumber("-3")).toString());
    assertEquals("8", new StringedNumber("3").subtraction(new StringedNumber("-5")).toString());
    assertEquals("22", new StringedNumber("55").subtraction(new StringedNumber("33")).toString());
    assertEquals("2000000000000000000000000000000000000000000000",
        new StringedNumber("5000000000000000000000000000000000000000000000").subtraction(new StringedNumber("3000000000000000000000000000000000000000000000")).toString());

    assertEquals("0", new StringedNumber("5").subtraction(new StringedNumber("5")).toString());
    assertEquals("0", new StringedNumber("33").subtraction(new StringedNumber("33")).toString());

    assertEquals("-2", new StringedNumber("3").subtraction(new StringedNumber("5")).toString());
    assertEquals("-22", new StringedNumber("33").subtraction(new StringedNumber("55")).toString());
    assertEquals("-2000000000000000000000000000000000000000000000",
        new StringedNumber("3000000000000000000000000000000000000000000000").subtraction(new StringedNumber("5000000000000000000000000000000000000000000000")).toString());
    assertEquals("46", new StringedNumber("1610").subtraction(new StringedNumber("1564")).toString());
    assertEquals("5492", new StringedNumber("6164").subtraction(new StringedNumber("672")).toString());
    assertEquals("10708531", new StringedNumber("10716273").subtraction(new StringedNumber("7742")).toString());
    assertEquals("39732152736216", new StringedNumber("40059431063562").subtraction(new StringedNumber("327278327346")).toString());
  }

  @Test
  public void multiplyTest() throws IOException
  {
//    assertEquals("7006652", new StringedNumber("1234").multiply(new StringedNumber("5678")).toString());
//    assertEquals("220", new StringedNumber("11").multiply(new StringedNumber("20")).toString());
//    assertEquals("220000", new StringedNumber("110").multiply(new StringedNumber("2000")).toString());
//    assertEquals("220000", new StringedNumber("1100").multiply(new StringedNumber("200")).toString());
//    assertEquals("2200000", new StringedNumber("1100").multiply(new StringedNumber("2000")).toString());
//    assertEquals("287769407308846640970310151509826255482575362419155842891311909556878670000425352112987881085839680", new StringedNumber("21625695688898558125310188636840316594920403182768")
//        .multiply(new StringedNumber("13306827740879180856696800391510469038934180115260")).toString());
//
//    String filePath = "/InputForAlgo/Week1Problem1.txt";
//    InputStream inputStream = getClass().getResourceAsStream(filePath);
//    List<ParseResult> parseResults = InputDataParser.parse(inputStream);
//    System.out.println(parseResults.get(0).getCounterMap());
//    for (ParseResult parseResult : parseResults)
//    {
//      assertEquals(parseResult.getValueZ(), new StringedNumber(parseResult.getValueX()).multiply(new StringedNumber(parseResult.getValueY())).toString());
//    }
    assertEquals("11989460275519080564894036768322865785999566885539505969749975204962718118914971586072960191064507745920086993438529097266122668", new StringedNumber("1685287499328328297814655639278583667919355849391453456921116729").multiply(new StringedNumber("7114192848577754587969744626558571536728983167954552999895348492")).toString());
//    StringedNumber stringedNumber = new StringedNumber("49823261");
//    assertEquals("2205647016448403", stringedNumber.multiply(new StringedNumber("44269423")).toString());
    System.out.println(StringedNumber.getMap());
  }
}
