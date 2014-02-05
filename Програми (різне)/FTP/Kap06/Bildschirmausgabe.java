import java.io.Console;

public class Bildschirmausgabe {
  public static void main(String[] args) {
    Console cons = System.console();
    cons.printf("\n");

    String ware = "Тетрадь";
    double preis = 1.75;
    cons.printf(" 1 %10s стоит %.2f евро \n", ware, preis);
    ware = "Ручка";
    preis = 0.55;
    cons.printf(" 1 %10s стоит %.2f евро \n", ware, preis);
  }
}
