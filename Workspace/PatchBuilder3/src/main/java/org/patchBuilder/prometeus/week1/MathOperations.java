package org.patchBuilder.prometeus.week1;

import org.apache.commons.lang3.math.NumberUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by OrestO
 * on 2/26/2015.
 */
public class MathOperations
{
    private static StringBuilder result = new StringBuilder();

    public static StringBuilder result(StringBuilder x, StringBuilder y)
    {
        StringBuilder stringBuilder = new StringBuilder();
        result.charAt(1);
        //Adding Leading zeros
        int n;
        if (x.length() == y.length())
        {
            n = x.length();
        }
        else if ( x.length() > y.length())
        {
            n = x.length();
            y = addZeros(y, n);
        }
        else
        {
           n = y.length();
           x = addZeros(x, n);
        }

        // Split X
        List<String> splitedX = split(x);

        // Split Y
        List<String> splitedY = split(y);


        if (n <= 2)
        {
            long a = Integer.parseInt(splitedX.get(0));
            long b = Integer.parseInt(splitedX.get(1));
            long c = Integer.parseInt(splitedY.get(0));
            long d = Integer.parseInt(splitedY.get(1));

            long ac = a * c;
            long bd = b * d;
            long adbc = (a + b) * (c + d) - ac - bd;
            result += Math.pow(10, n) * ac + Math.pow(10, n/2) * adbc + bd;
        }
        else
        {
            String a = splitedX.get(0);
            String b = splitedX.get(1);
            String c = splitedY.get(0);
            String d = splitedY.get(1);

            String ac = result(splitedX.get(0), splitedY.get(0));
            String bd = result(splitedX.get(1), splitedY.get(1));
            //ad+bc=(a+b)(c+d)−ac−bd
            String adbc = subtraction(subtraction(result(add(a, b), add(c, d)), ac), bd);
            String adbc = result(add(a, b), add(c, d)).subtraction(ac).subtraction(bd);
            //X⋅Y=10nac+10n/2(ad+bc)+bd
//            result.append(Math.pow(10, n) * ac + Math.pow(10, n/2) * adbc + bd);
        }

        return result;
    }

    private static String addZeros(String str, int n)
    {
        StringBuilder temp = new StringBuilder();
        for (int i = 0; i < n - str.length(); i++)
        {
            temp.append("0");
        }
        return temp.append(str).toString();
    }

    private static List<String> split(String s)
    {
        List<String> list = new ArrayList<>(2);
        list.add(s.substring(0, s.length()/2));
        list.add(s.substring(s.length()/2));
        return list;
    }

    public static String add(String a, String b)
    {

        // -5 + -3 = -8
        if (a.charAt(0) == '-' && b.charAt(0) == '-')
        {
            return '-' + add(a.substring(1), b.substring(1));
        }
        else if (b.charAt(0) == '-')
        {
            return subtraction(a, b.substring(1));
        }
        else if (a.charAt(0) == '-')
        {
            return '-' + subtraction(a.substring(1), b);
        }
        else if (a.length() >= b.length())
        {
            return orderedAddition(a, b);
        }
        else
        {
            return orderedAddition(b, a);
        }

    }

    private static String orderedAddition(String a, String b)
    {
        StringBuilder result = new StringBuilder();

        int store = 0;
        int temp;
        int diff = a.length() - b.length();

        for(int i = a.length() - 1; i >= 0; i--)
        {
            if (i - diff >= 0)
            {
                temp = Integer.parseInt("" + a.charAt(i)) + Integer.parseInt("" + b.charAt(i - diff)) + store;
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

        return result.reverse().toString();
    }

    public static String powOfTen(int n)
    {
        String result = "1";

        if(n == 1)
        {
            result += "0";
        }
        else if (n > 1)
        {
            for (int i = 0; i < n; i++)
            {
                result += "0";
            }
        }
        return result;
    }

    public static String subtraction(String a, String b)
    {
        String result = "";

        //5 - -3 = 8
        if (a.charAt(0) != '-' && b.charAt(0) == '-')
        {
            return add(a, b.substring(1));
        }
        //-5 - 3 = -8
        else if (a.charAt(0) == '-' && b.charAt(0) != '-')
        {
            return '-' + add(a.substring(1), b);
        }
        else
        {
            boolean isMinus = false;
            // -5 - -3 = -2
            // -3 - -5 = 2
            if (a.charAt(0) == '-')
            {
                a = a.substring(1);
                b = b.substring(1);
                isMinus = true;
            }
            //5 - 5 = 0
            if (compare(a, b) == 0)
            {
                result = "0";
            }
            // 5 - 3 = 2
            else if (compare(a, b) > 0)
            {
                result = isMinus ? "-" : "" + orderedSubtraction(a, b);
            }
            else
            {
                result = !isMinus ? "-" : "" + orderedSubtraction(b, a);
            }
        }

        return result;
    }

    private static String orderedSubtraction(String a, String b)
    {
        StringBuilder result = new StringBuilder();

        int store = 0;
        int temp;
        int diff = a.length() - b.length();

        for(int i = a.length() - 1; i >= 0; i--)
        {
            if (i - diff >= 0)
            {
                temp = Integer.parseInt("" + a.charAt(i)) - Integer.parseInt("" + b.charAt(i - diff)) - store;
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
                result.append(a.charAt(i));
            }
        }

        return result.reverse().toString();
    }

    // a=15, b=10 => 5
    // a=5, b=10 => -1
    // a=15, b=1 => 1
    private static int compare(String a, String b)
    {
        if (a.length() == b.length())
        {
            int temp;
            for (int i = 0; i < a.length(); i++)
            {
                temp = Integer.parseInt("" + a.charAt(i)) - Integer.parseInt("" + b.charAt(i));
                if (temp != 0)
                {
                    return temp;
                }
            }
        }
        return a.length() - b.length();
    }
}
