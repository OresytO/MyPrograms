  import java.util.*;
  import java.io.*;

  class Umdrehen {
    public static void main(String [] args) {
    Console cons = System.console();
    cons.printf("\n");

    cons.printf(" ������� �����: ");
    String eingabeWort = cons.readLine();

int anzahl = eingabeWort.length();

// ������� ���� � �������� ������
    Stack<Character> keller = new Stack<Character>();
    for(int i = 0; i < anzahl; i++) {
      keller.push(eingabeWort.charAt(i));
    }

    // ���������� � ����� ��������� �� �����
    cons.printf(" ����������: ");
    for(int i = 0; i < anzahl; i++) {
      cons.printf("%s", keller.pop());
    }

    cons.printf("\n");
  }
}
