import org.junit.Test;
import org.patchBuilder.prometeus.week1.MathOperations;

import static org.junit.Assert.assertEquals;

/**
 * Created by OrestO
 * on 3/1/2015.
 */

public class MathOperationsTest
{
    @Test
    public void testAddition()
    {
        assertEquals("579", MathOperations.add("123", "456").toString());
        assertEquals("-2", MathOperations.add("-5", "3").toString());
        assertEquals("2", MathOperations.add("5", "-3").toString());
        assertEquals("-8", MathOperations.add("-5", "-3").toString());
        assertEquals("1122", MathOperations.add("123", "999").toString());
        assertEquals("57900000000000000000000000000000000000000000000000000000000000000000000000000000000", MathOperations.add("12300000000000000000000000000000000000000000000000000000000000000000000000000000000", "45600000000000000000000000000000000000000000000000000000000000000000000000000000000").toString());

        assertEquals("120", MathOperations.add("123", "-3").toString());
        assertEquals("-200", MathOperations.add("100", "-300").toString());

    }

    @Test
    public void testPow()
    {
        assertEquals("1", MathOperations.powOfTen(0).toString());
        assertEquals("10", MathOperations.powOfTen(1).toString());
        assertEquals("100000", MathOperations.powOfTen(5).toString());
        assertEquals("1000000000000000", MathOperations.powOfTen(15).toString());
    }

    @Test
    public void testSubstration()
    {
        assertEquals("2", MathOperations.subtraction("5", "3").toString());
        assertEquals("-2", MathOperations.subtraction("3", "5").toString());
        assertEquals("-8", MathOperations.subtraction("-5", "3").toString());
        assertEquals("-8", MathOperations.subtraction("-3", "5").toString());
        assertEquals("-2", MathOperations.subtraction("-5", "-3").toString());
        assertEquals("2", MathOperations.subtraction("-3", "-5").toString());
        assertEquals("8", MathOperations.subtraction("5", "-3").toString());
        assertEquals("8", MathOperations.subtraction("3", "-5").toString());
        assertEquals("22", MathOperations.subtraction("55", "33").toString());
        assertEquals("2000000000000000000000000000000000000000000000", MathOperations.subtraction("5000000000000000000000000000000000000000000000", "3000000000000000000000000000000000000000000000").toString());

        assertEquals("0", MathOperations.subtraction("5", "5").toString());
        assertEquals("0", MathOperations.subtraction("33", "33").toString());

        assertEquals("-2", MathOperations.subtraction("3", "5").toString());
        assertEquals("-22", MathOperations.subtraction("33", "55").toString());
        assertEquals("-2000000000000000000000000000000000000000000000", MathOperations.subtraction("3000000000000000000000000000000000000000000000", "5000000000000000000000000000000000000000000000").toString());

    }
}
