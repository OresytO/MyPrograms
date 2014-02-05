import java.util.*;
import java.io.*;

  class Item {
    String m_name;
    int m_nummer;
    // Конструктор
    Item(String derName,int dieNummer) {
      m_name = derName;
      m_nummer = dieNummer;
  }
}
public class ListenDemo {
  public static void main(String []args) {
    // Размещение списка и вставка нескольких имен в конец списка
    LinkedList<Item> freunde = new LinkedList<Item>();

    Item aktuell = new Item("Дирк",455689);
    freunde.add(aktuell); // добавление в конец списка

    aktuell = new Item("Пэтэр",543679);
    freunde.add(aktuell); // добавление в конец списка

    // Непосредственно создаем объект в конструкторе
    // и добавляем в конец списка
    freunde.add(new Item("Катя",238590));

    // Непосредственно создаем объект в конструкторе
    // и добавляем в конец списка
    freunde.add(0, new Item("Джулия",749326));

    // Вывод содержимого списка тремя различными способами
    Console cons = System.console();

    cons.printf("\n Вывод с помощью get() \n");
    for(int i = 0; i < freunde.size(); i++) {
      aktuell = freunde.get(i);
      cons.printf(" %s %d\n", aktuell.m_name, aktuell.m_nummer);
    }

    cons.printf ("\n Вывод с помощью итераторов\n");
    Iterator<Item> it = freunde.iterator();
    while(it.hasNext()) {
      aktuell = it.next();
      cons.printf(" %s %d\n", aktuell.m_name, aktuell.m_nummer);
    }
    cons.printf ("\n Вывод с помощью for \n");
    for(Item akt : freunde) {
      cons.printf(" %s %d\n", akt.m_name, akt.m_nummer);
    }
  }
}
