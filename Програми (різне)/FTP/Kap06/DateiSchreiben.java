import java.io.PrintWriter;

public class DateiSchreiben {
  public static void main(String[] args) {
    // Файл ввода и вывода должен охраняться с помощью
    // конструкции try-catch
    try {
      PrintWriter ausgabe = new PrintWriter("Test.txt");
      // Test.txt - файл для вывода информации
      String ware = "Тетрадь";
      double preis = 1.75;
      ausgabe.printf(" 1 " + ware + " стоит " + preis + " евро%n");
      ware = "Ручка";
      preis = 0.55;
      ausgabe.printf(" 1 " + ware + " стоит " + preis + " евро%n");
      ausgabe.close();
    }
      catch(Exception e) { System.err.println(e);
    }
  }
}
