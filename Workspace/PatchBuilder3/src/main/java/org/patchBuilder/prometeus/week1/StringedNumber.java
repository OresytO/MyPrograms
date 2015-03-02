package org.patchBuilder.prometeus.week1;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author OrestOskyy
 * @since 3.7.0.
 */
public class StringedNumber
{
  private StringBuilder result;
  private boolean isNegative;

  public StringedNumber(String number)
  {
    isNegative = number.charAt(0) == '-';
    result = new StringBuilder(isNegative ? number.substring(1) : number);
  }

  public StringedNumber(StringBuilder number)
  {
    isNegative = number.charAt(0) == '-';
    result = new StringBuilder(isNegative ? number.substring(1) : number);
  }

  public StringedNumber(double number)
  {
    isNegative = number > 0;
    result = new StringBuilder("" + (isNegative ? (number * -1) : number));
  }

  public StringedNumber result(StringedNumber y)
  {
    StringBuilder stringBuilder = new StringBuilder();
    // Adding Leading zeros
    int n;
    if (this.length() == y.length())
    {
      n = this.length();
    }
    else if (this.length() > y.length())
    {
      n = this.length();
      y = y.addZeros(n);
    }
    else
    {
      n = y.length();
      this.addZeros(n);
    }

    // Split X
    List<StringedNumber> splitedX = this.split(n);

    // Split Y
    List<StringedNumber> splitedY = y.split(n);

    if (n <= 2)
    {
      long a = splitedX.get(0).intValue();
      long b = splitedX.get(1).intValue();
      long c = splitedY.get(0).intValue();
      long d = splitedY.get(1).intValue();

      long ac = a * c;
      long bd = b * d;
      long adbc = (a + b) * (c + d) - ac - bd;
      return new StringedNumber(Math.pow(10, n) * ac + Math.pow(10, n / 2) * adbc + bd);
    }
    else
    {
      StringedNumber a = splitedX.get(0);
      StringedNumber b = splitedX.get(1);
      StringedNumber c = splitedY.get(0);
      StringedNumber d = splitedY.get(1);

      StringedNumber ac = a.result(c);
      StringedNumber bd = b.result(d);
      // ad+bc=(a+b)(c+d)−ac−bd
//      StringedNumber adbc = subtraction(subtraction(result(add(a, b), add(c, d)), ac), bd);
      StringedNumber adbc = a.add(b).result(c.add(d)).subtraction(ac).subtraction(bd);
      // X⋅Y=10nac+10n/2(ad+bc)+bd
      // result.append(Math.pow(10, n) * ac + Math.pow(10, n/2) * adbc + bd);
      return powOfTen(n).result(ac).add(powOfTen(n/2).result(adbc)).add(bd);
    }

  }

  private StringedNumber addZeros(int n)
  {
    for (int i = 0; i < n - result.length(); i++)
    {
      result.insert(0, "0");
    }
    return this;
  }

  public List<StringedNumber> split(int n)
    {
      List<StringedNumber> list = new ArrayList<>(n);
      int previous = 0;
      for (int i = 1; i <= n; i++)
      {
        list.add(new StringedNumber(result.substring(previous, i * result.length()/n)));
        previous = i * result.length()/n;

      }
//        list.add(result.substring(0, result.length()/2));
//        list.add(result.substring(result.length()/2));
      return list;
    }

  public StringedNumber add(StringedNumber b)
  {

    // -5 + -3 = -8
    if (this.isNegative() && b.isNegative())
    {
      return this.add(b).makeNagative();
    }
    else if (b.isNegative())
    {
      return this.subtraction(b);
    }
    else if (this.isNegative())
    {
      return this.subtraction(b).makeNagative();
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
        break;
      }
    }

    if (store > 0)
    {
      result.append(store);
    }

    return new StringedNumber(result.reverse());
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
      return this.add(b);
    }
    // -5 - 3 = -8
    else if (this.isNegative() && !b.isNegative())
    {
      return this.add(b).makeNagative();
    }
    else
    {
      /*boolean isMinus = false;*/
      // -5 - -3 = -2
      // -3 - -5 = 2
      /*if (this.isNegative())
      {
        isMinus = true;
      }*/
      // 5 - 5 = 0
      if (this.compareTo(b) == 0)
      {
        return new StringedNumber("0");
      }
      // 5 - 3 = 2
      else if (this.compareTo(b) > 0)
      {
        return /*this.isNegative() ? "-" : "" +*/ this.orderedSubtraction(b);
      }
      else
      {
        return /*!this.isNegative() ? "-" : "" +*/ b.orderedSubtraction(this);
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
        temp = this.numberAt(i) - b.numberAt(i - diff) - store;
        store = 0;
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
        result.append(this.numberAt(i));
      }
    }

    return new StringedNumber(result.reverse());
  }

  // a=15, b=10 => 5
  // a=5, b=10 => -1
  // a=15, b=1 => 1
  private int compareTo(StringedNumber b)
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
            return temp;
          }
        }
      }
    }
    return this.length() - b.length();
  }

  public int length()
  {
    return result.length();
  }

  public int numberAt(int i)
  {
    return Integer.parseInt("" + result.charAt(i));
  }

  public boolean isNegative()
  {
    return isNegative;
  }

  @Override
  public String toString()
  {
    return result.toString();
  }

  private StringedNumber makeNagative()
  {
    isNegative = true;
    return this;
  }

  public int intValue()
  {
    return Integer.parseInt(result.toString());
  }
}
