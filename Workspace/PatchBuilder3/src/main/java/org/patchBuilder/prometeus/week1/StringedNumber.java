package org.patchBuilder.prometeus.week1;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author olozynskyy
 * @since 3.7.0
 */
public class StringedNumber
{
  private StringBuilder unsignedNumber;
  private boolean isNegative;
  private static Map<Integer, Integer> map = new HashMap<>();

  public StringedNumber(String number)
  {
    isNegative = number.charAt(0) == '-';
    this.unsignedNumber = new StringBuilder(isNegative ? number.substring(1) : number);
  }

  public StringedNumber(StringedNumber number)
  {
    isNegative = number.isNegative();
    this.unsignedNumber = new StringBuilder(number.getUnsignedNumber());
  }

  public StringedNumber(StringBuilder number)
  {
    isNegative = number.charAt(0) == '-';
    this.unsignedNumber = new StringBuilder(isNegative ? number.substring(1) : number);
  }

  public StringedNumber(double number)
  {
    isNegative = number < 0;
    this.unsignedNumber = new StringBuilder("" + (int) (isNegative ? (number * -1) : number));
  }

  public StringedNumber multiply(StringedNumber y)
  {
    // Adding Leading zeros
    int n;
    if (this.length() == y.length())
    {
      n = this.length();
    }
    else if (this.length() > y.length())
    {
      n = this.length();
      y = y.addLeadingZeros(n - y.length());
    }
    else
    {
      n = y.length();
      this.addLeadingZeros(n - this.length());
    }

    if (n > 2 && n % 2 == 1)
    {
      n++;
      this.addLeadingZeros(n - this.length());
      y.addLeadingZeros(n - y.length());
    }
    // Split X
    List<StringedNumber> splitedX = this.split(2);

    // Split Y
    List<StringedNumber> splitedY = y.split(2);

    if (n <= 2)
    {
      int a = splitedX.get(0).intValue();
      int b = splitedX.get(1).intValue();
      int c = splitedY.get(0).intValue();
      int d = splitedY.get(1).intValue();

      int ac = a * c;
      int bd = b * d;
      int adbc = (a + b) * (c + d) - ac - bd;
      if (map.containsKey(adbc)) {
        Integer i = map.get(adbc);
        map.put(adbc, ++i);
      } else {
        map.put(adbc, 1);
      }
      System.out.println(adbc);
      return new StringedNumber(Math.pow(10, n) * ac + Math.pow(10, n / 2) * adbc + bd);
    }
    else
    {
      StringedNumber a = splitedX.get(0);
      StringedNumber b = splitedX.get(1);
      StringedNumber c = splitedY.get(0);
      StringedNumber d = splitedY.get(1);

      StringedNumber ac = a.multiply(c);
      StringedNumber bd = b.multiply(d);
      StringedNumber adbc1 = a.add(b);
      StringedNumber adbc2 = c.add(d);
      StringedNumber adbc3 = adbc1.multiply(adbc2);
      StringedNumber adbc4 = adbc3.subtraction(ac);
      StringedNumber adbc = adbc4.subtraction(bd);
//      if (map.containsKey(adbc))
//      {
//        Integer i = map.get(adbc);
//
//        map.put(adbc.intValue(), ++i);
//      }
//      else
//      {
//        map.put(adbc.intValue(), 1);
//      }
      // StringedNumber adbc =
      // a.add(b).multiply(c.add(d)).subtraction(ac).subtraction(bd);

      System.out.println(adbc);
      StringedNumber result = ac.addTailingZeros(n).add(adbc.addTailingZeros(n / 2)).add(bd);
      return result;
      // return powOfTen(n).multiply(ac).add(powOfTen(n /
      // 2).multiply(adbc)).add(bd);
    }

  }

  private StringedNumber addLeadingZeros(int n)
  {
    for (int i = 0; i < n; i++)
    {
      unsignedNumber.insert(0, "0");
    }
    return this;
  }

  private StringedNumber addTailingZeros(int n)
  {
    if (isZero())
    {
      unsignedNumber.delete(0, unsignedNumber.length());
      unsignedNumber.append(0);
    }
    else if (n == 0)
    {
      unsignedNumber.delete(0, unsignedNumber.length());
      unsignedNumber.append(1);
    }
    else if (n == 1)
    {
      // DO nothing
      return this;
    }
    else
    {
      for (int i = 0; i < n; i++)
      {
        unsignedNumber.append("0");
      }
    }
    return this;
  }

  private boolean isZero()
  {
    return unsignedNumber.toString().replaceAll("0", "").length() == 0;
  }

  public List<StringedNumber> split(int n)
  {
    List<StringedNumber> list = new ArrayList<>(n);
    int previous = 0;
    for (int i = 1; i <= n; i++)
    {
      list.add(new StringedNumber(unsignedNumber.substring(previous, i * unsignedNumber.length() / n)));
      previous = i * unsignedNumber.length() / n;

    }
    return list;
  }

  public StringedNumber add(StringedNumber b)
  {

    // -5 + -3 = -8
    if (this.isNegative() && b.isNegative())
    {
      return this.makePositive().add(b.makePositive()).makeNegative();
    }
    // 5 + -3 =
    else if (b.isNegative())
    {
      return this.subtraction(b.makePositive());
    }
    else if (this.isNegative())
    {
      return this.makePositive().subtraction(b).makeNegative();
    }
    else if (this.length() >= b.length())
    {
      return this.orderedAddition(b);
    }
    else
    {
      return b.orderedAddition(this);
    }

  }

  private StringedNumber orderedAddition(StringedNumber b)
  {
    StringBuilder result = new StringBuilder();

    int store = 0;
    int temp;
    int diff = this.length() - b.length();

    if (b.isZero())
    {
      return new StringedNumber(this);
    }
    for (int i = this.length() - 1; i >= 0; i--)
    {
      if (i - diff >= 0)
      {
        temp = this.numberAt(i) + b.numberAt(i - diff) + store;
        store = 0;
        if (temp >= 10)
        {
          result.append(temp - 10);
          store = 1;
        }
        else
        {
          result.append(temp);
        }
      }
      else
      {
        temp = this.numberAt(i) + store;
        store = 0;
        if (temp >= 10)
        {
          result.append(temp - 10);
          store = 1;
        }
        else
        {
          result.append(temp);
        }

      }
    }

    if (store > 0)
    {
      result.append(store);
    }

    return new StringedNumber(result.reverse().toString());
  }

  public static StringedNumber powOfTen(int n)
  {
    StringBuilder result = new StringBuilder("1");

    if (n == 1)
    {
      result.append("0");
    }
    else if (n > 1)
    {
      for (int i = 0; i < n; i++)
      {
        result.append("0");
      }
    }
    return new StringedNumber(result);
  }

  public StringedNumber subtraction(StringedNumber b)
  {
    // 5 - -3 = 8
    if (!this.isNegative() && b.isNegative())
    {
      return this.add(b.makePositive());
    }
    // -5 - 3 = -8
    else if (this.isNegative() && !b.isNegative())
    {
      return this.makePositive().add(b).makeNegative();
    }
    else
    {
      /* boolean isMinus = false; */
      // -5 - -3 = -2
      // -3 - -5 = 2
      /*
       * if (this.isNegative()) { isMinus = true; }
       */
      // 5 - 5 = 0
      if (this.compareTo(b) == 0)
      {
        return new StringedNumber("0");
      }
      // 5 - 3 = 2
      // -3 - -5 = 2
      else if (this.compareTo(b) > 0)
      {
        if (this.isNegative)
        {
          return b.makePositive().orderedSubtraction(this.makePositive());
        }
        // System.out.println(this + " " + b);
        return this.orderedSubtraction(b);
      }
      // 3 - 5 = -2
      // -5 - -3 = -2
      else
      {
        if (this.isNegative)
        {
          return this.makePositive().orderedSubtraction(b.makePositive()).makeNegative();
        }
        return b.orderedSubtraction(this).makeNegative();
      }
    }

  }

  private StringedNumber orderedSubtraction(StringedNumber b)
  {
    StringBuilder result = new StringBuilder();

    int store = 0;
    int temp;
    int diff = this.length() - b.length();

    for (int i = this.length() - 1; i >= 0; i--)
    {
      if (i - diff >= 0)
      {
        int x = this.numberAt(i) - store;
        store = 0;
        int y = b.numberAt(i - diff);
        if (x == y)
        {
          temp = 0;
        }
        else if (x > y)
        {
          temp = x - y;
        }
        else
        {
          temp = 10 + x - y;
          store = 1;
        }
        if (temp < 0)
        {
          result.append(-temp);
          store = 1;
        }
        else
        {
          result.append(temp);
        }
      }
      else
      {
        temp = this.numberAt(i) - store;
        if (temp >= 0)
        {
          store = 0;
        }
        else
        {
          temp = 9;
        }
        result.append(temp);
      }
    }

    return new StringedNumber(result.reverse()).removeLeadingZeros();
  }

  private StringedNumber removeLeadingZeros()
  {
    while (true)
    {
      if (this.numberAt(0) == 0)
      {
        this.unsignedNumber.deleteCharAt(0);
      }
      else
      {
        break;
      }
    }
    return this;
  }

  // a=15, b=10 => 5
  // a=5, b=10 => -1
  // a=15, b=1 => 1
  public int compareTo(StringedNumber b)
  {
    if (this.isNegative() && !b.isNegative())
    {
      return -1;
    }
    else if (!this.isNegative() && b.isNegative())
    {
      return 1;
    }
    else
    {
      if (this.length() == b.length())
      {
        int temp;
        for (int i = 0; i < this.length(); i++)
        {
          temp = this.numberAt(i) - b.numberAt(i);
          if (temp != 0)
          {
            return temp * (this.isNegative() ? -1 : 1);
          }
        }
      }
      return (this.length() - b.length()) * (this.isNegative() ? -1 : 1);
    }
  }

  public int length()
  {
    return unsignedNumber.length();
  }

  public int numberAt(int i)
  {
    return Integer.parseInt("" + unsignedNumber.charAt(i));
  }

  public boolean isNegative()
  {
    return isNegative;
  }

  @Override
  public String toString()
  {
    return (isNegative() ? "-" : "") + unsignedNumber.toString();
  }

  private StringedNumber makeNegative()
  {
    isNegative = true;
    return this;
  }

  private StringedNumber makePositive()
  {
    isNegative = false;
    return this;
  }

  public int intValue()
  {
    return Integer.parseInt(unsignedNumber.toString());
  }

  public String getUnsignedNumber()
  {
    return unsignedNumber.toString();
  }

  public static Map<Integer, Integer> getMap() {
    return map;
  }
}
