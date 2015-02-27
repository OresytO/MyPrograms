package org.patchBuilder.prometeus.week1;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by OrestO
 * on 2/26/2015.
 */
public class Multiply
{
    public static StringBuilder result(String x, String y)
    {
        StringBuilder result = new StringBuilder();

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

        //X⋅Y=10nac+10n/2(ad+bc)+bd
        //ad+bc=(a+b)(c+d)−ac−bd

        if (n <= 8)
        {
            long a = Integer.parseInt(splitedX.get(0));
            long b = Integer.parseInt(splitedX.get(1));
            long c = Integer.parseInt(splitedY.get(0));
            long d = Integer.parseInt(splitedY.get(1));

            long ac = a * c;
            long bd = b * d;
            long adbc = (a + b) * (c + d) - ac - bd;
            result.append(Math.pow(10, n) * ac + Math.pow(10, n/2) * adbc + bd);
        }
        else
        {
            long a = Integer.parseInt(splitedX.get(0));
            long b = Integer.parseInt(splitedX.get(1));
            long c = Integer.parseInt(splitedY.get(0));
            long d = Integer.parseInt(splitedY.get(1));

            long ac = result(splitedX.get(0), splitedY.get(0));
            long bd = result(splitedX.get(1), splitedY.get(1));
            long adbc = (a + b) * (c + d) - ac - bd;
            result.append(Math.pow(10, n) * ac + Math.pow(10, n/2) * adbc + bd);
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
}
