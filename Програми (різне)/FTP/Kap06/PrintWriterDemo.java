import java.io.PrintWriter;
public class PrintWriterDemo {
  public static void main(String[] args) {
    PrintWriter ausgabe = new PrintWriter(System.out);

    ausgabe.println();

    String ware = "�������";
    double preis = 1.75;
    ausgabe.printf(" 1 %10s ����� %.2f ���� \n", ware, preis);

    ware = "�����";
    preis = 0.55;
    ausgabe.printf(" 1 %10s ����� %.2f ���� \n", ware, preis);

    ausgabe.close();
  }
}
