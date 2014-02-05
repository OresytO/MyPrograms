import java.util.*;
import java.io.*;

  class Item {
    String m_name;
    int m_nummer;
    // �����������
    Item(String derName,int dieNummer) {
      m_name = derName;
      m_nummer = dieNummer;
  }
}
public class ListenDemo {
  public static void main(String []args) {
    // ���������� ������ � ������� ���������� ���� � ����� ������
    LinkedList<Item> freunde = new LinkedList<Item>();

    Item aktuell = new Item("����",455689);
    freunde.add(aktuell); // ���������� � ����� ������

    aktuell = new Item("�����",543679);
    freunde.add(aktuell); // ���������� � ����� ������

    // ��������������� ������� ������ � ������������
    // � ��������� � ����� ������
    freunde.add(new Item("����",238590));

    // ��������������� ������� ������ � ������������
    // � ��������� � ����� ������
    freunde.add(0, new Item("������",749326));

    // ����� ����������� ������ ����� ���������� ���������
    Console cons = System.console();

    cons.printf("\n ����� � ������� get() \n");
    for(int i = 0; i < freunde.size(); i++) {
      aktuell = freunde.get(i);
      cons.printf(" %s %d\n", aktuell.m_name, aktuell.m_nummer);
    }

    cons.printf ("\n ����� � ������� ����������\n");
    Iterator<Item> it = freunde.iterator();
    while(it.hasNext()) {
      aktuell = it.next();
      cons.printf(" %s %d\n", aktuell.m_name, aktuell.m_nummer);
    }
    cons.printf ("\n ����� � ������� for \n");
    for(Item akt : freunde) {
      cons.printf(" %s %d\n", akt.m_name, akt.m_nummer);
    }
  }
}
