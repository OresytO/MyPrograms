import java.io.PrintWriter;

public class DateiSchreiben {
  public static void main(String[] args) {
    // ���� ����� � ������ ������ ���������� � �������
    // ����������� try-catch
    try {
      PrintWriter ausgabe = new PrintWriter("Test.txt");
      // Test.txt - ���� ��� ������ ����������
      String ware = "�������";
      double preis = 1.75;
      ausgabe.printf(" 1 " + ware + " ����� " + preis + " ����%n");
      ware = "�����";
      preis = 0.55;
      ausgabe.printf(" 1 " + ware + " ����� " + preis + " ����%n");
      ausgabe.close();
    }
      catch(Exception e) { System.err.println(e);
    }
  }
}
