import org.junit.Test;
import org.patchBuilder.prometeus.week1.StringedNumber;

import static org.junit.Assert.assertEquals;

/**
 *
 * @author olozynskyy
 * @since 3.7.0
 */
public class StringedNumberTest
{
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
  }

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
  public void resultTest()
  {
    assertEquals("220", new StringedNumber("11").multiply(new StringedNumber("20")).toString());
    assertEquals("220000", new StringedNumber("110").multiply(new StringedNumber("2000")).toString());
    assertEquals("220000", new StringedNumber("1100").multiply(new StringedNumber("200")).toString());
    assertEquals("2200000", new StringedNumber("1100").multiply(new StringedNumber("2000")).toString());
  }
}
