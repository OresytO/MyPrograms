import java.io.PrintWriter;
public class PrintWriterDemo {
  public static void main(String[] args) {
    PrintWriter ausgabe = new PrintWriter(System.out);

    ausgabe.println();

    String ware = "Тетрадь";
    double preis = 1.75;
    ausgabe.printf(" 1 %10s стоит %.2f евро \n", ware, preis);

    ware = "Ручка";
    preis = 0.55;
    ausgabe.printf(" 1 %10s стоит %.2f евро \n", ware, preis);

    ausgabe.close();
  }
}
