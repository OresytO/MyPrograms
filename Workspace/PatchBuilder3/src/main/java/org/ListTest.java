package org;

import java.util.ArrayList;
import java.util.List;

class Elem
{
  private Elem parent;
  private String data;

  public Elem(String str)
  {
    parent = null;
    data = str;
  }

  public Elem getParent()
  {
    return parent;
  }

  public void changeParent(Elem parent)
  {
    this.parent = parent;
  }

  @Override
  public String toString()
  {
    String str = data;
    if (parent == null)
      return str;
    return str + "\n" + parent.toString();
  }
}

public class ListTest
{

  private static List<Elem> generator(int count)
  {
    List<Elem> list = new ArrayList<>();
    for (int i = 0; i < count; i++)
    {
      list.add(new Elem("element №" + i));
    }
    return list;
  }

  public static void main(String[] args)
  {
    Elem child = null;
    boolean first = true;
    Elem pt = new Elem("pt elem");

    child = pt;
    for (Elem temp : generator(10))
    {
      child.changeParent(temp);
      if (first)
        first = false;
      else
        child = temp;
    }

    System.out.println(pt);
  }
}
