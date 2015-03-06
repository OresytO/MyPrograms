package org.patchBuilder.Xml.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringEscapeUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.patchBuilder.Xml.Parser;
import org.patchBuilder.utils.CONST;

public class ParserImpl implements Parser
{

  @Override
  public Map<String, List<String>> parse(String path, List<String> tags)
  {
    File input = new File(path);
    Map<String, List<String>> map = new HashMap<>();
    Integer i = 0;
    String str;
    Document doc;
    try
    {
      doc = Jsoup.parse(input, CONST.UTF_8);
      for (Element elements : doc.getElementsByTag("ROW"))
      {
        List<String> temp = new ArrayList<>();
        for (String tag : tags)
        {
          if (tag.equals(tags.get(0)))
          {
            i = Integer.parseInt(elements.getElementsByTag(tag).text());
          }
          else
          {
            str = elements.getElementsByTag(tag).text();
            str = fixString(str);
            // str = (str == null || str.equals(CONST.NULL)) ? null
            // : str;
            temp.add(str);
          }
        }
        map.put(i.toString(), temp);
      }
    }
    catch (IOException e)
    {
      e.printStackTrace();
    }
    return map;
  }

  private String fixString(String content)
  {
    if (content == null || content.equals(CONST.NULL))
    {
      return CONST.NULL;
    }
    else if (content.contains("&amp;#") || content.contains("&#"))
    {
      String str = StringEscapeUtils.unescapeHtml4(content);
      str = str.replaceAll("\"", "\\\\\"");
      // str = str.replaceAll("\'", "\\\\\'");
      return str;
    }
    else
    {
      return CONST.NULL;
    }
  }

}
