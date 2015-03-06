package org.Lists;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;

@SuppressWarnings("serial")
public class MyListExt<T> extends ArrayList<T>
{
  public MyListExt()
  {
    super();

  }

  public MyListExt(Collection<T> coll)
  {
    super(coll);
  }

  @SuppressWarnings("unchecked")
  public MyListExt(T... args)
  {
    super(Arrays.asList(args));
  }

  @Override
  public String toString()
  {
    String str = "";
    for (T obj : this)
    {
      str += obj.toString();
    }
    return str;
  }
}
