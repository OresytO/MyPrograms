import java.util.*;
import java.io.*;
class Item {
  String m_wort,m_typ;
    Item(String w,String t) {
      m_wort = w;
      m_typ = t;

  }
}
public class Woerterbuch {
  public static void main(String args[]) {
    Console cons = System.console();
    cons.printf("\n");

    HashMap<String, Item> tabelle = new HashMap<String, Item>();
    tabelle.put("gehen",          new Item("walk","Verb"));
    tabelle.put("laufen",         new Item("run","Verb"));
    tabelle.put("schwimmen",      new Item("swim","Verb"));
    tabelle.put("Rei?verschluss", new Item("zipper","Nomen"));
    // Поиск соответствующего слова
    Scanner tastatur = new Scanner(cons.reader());
    cons.printf(" Введите немецкое слово: ");
    String suchString = tastatur.next();
    // Поиск в хэш-таблице
    Item ergebnis = tabelle.get(suchString);
    if(ergebnis == null)
      cons.printf(" %s не найдено! \n", suchString);
    else
      cons.printf(" %s по-английски %s \n", suchString, ergebnis.m_wort);
    }
}
