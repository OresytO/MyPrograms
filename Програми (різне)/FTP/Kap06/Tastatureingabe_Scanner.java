import java.util.*;
import java.io.Console;
public class Tastatureingabe_Scanner {
  public static void main(String[] args) {
    Console cons = System.console();
    Scanner sc = new Scanner(System.console().reader());
    // ������ Scanner ��������� �� ������ console().reader()
    cons.printf("\n");
    try {
      cons.printf(" ������� �������: ");
      String name = sc.nextLine();

      // ������ sc ��������� ��� ������ ��� string
      cons.printf(" ������� ���� �������: ");
      int alter = sc.nextInt();

      // ������ sc ��������� ��������� �����, ��� ����� �����
      cons.printf("\n");
      cons.printf(" %d ���� (���)?", alter);
      cons.printf(" �� �� �����������, �-� ��� �-�� %s?\n", name);
    }
    catch (InputMismatchException e) {
      System.err.println("\n ������! \n" +
        " ���������� ��������� �������������� � ��������� ����.");
    }
  }
}
