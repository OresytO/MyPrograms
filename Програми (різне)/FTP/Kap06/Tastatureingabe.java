import java.io.Console;

public class Tastatureingabe {
  public static void main(String[] args) {
    Console cons = System.console();
    cons.printf("\n");
    try {
      cons.printf("������� �������: ");
      String name = cons.readLine();

      cons.printf("������� ���� �������: ");
      // ������� ��� �������
      String eingabe = cons.readLine();
      int alter = Integer.parseInt(eingabe);

      cons.printf("\n");
      cons.printf(" %d ���� (���)?", alter);
      // ������� ���?
      cons.printf(" �� �� �����������, �-� ��� �-�� %s?\n", name);
    }
    catch (NumberFormatException e) {
      System.err.println("\n ������! \n" +
      " ���������� ��������� �������������� � ��������� ����.");
    }
  }
}
