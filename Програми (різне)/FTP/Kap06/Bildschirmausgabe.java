import java.io.Console;

public class Bildschirmausgabe {
  public static void main(String[] args) {
    Console cons = System.console();
    cons.printf("\n");

    String ware = "�������";
    double preis = 1.75;
    cons.printf(" 1 %10s ����� %.2f ���� \n", ware, preis);
    ware = "�����";
    preis = 0.55;
    cons.printf(" 1 %10s ����� %.2f ���� \n", ware, preis);
  }
}
