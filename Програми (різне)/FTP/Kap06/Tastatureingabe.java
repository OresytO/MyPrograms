import java.io.Console;

public class Tastatureingabe {
  public static void main(String[] args) {
    Console cons = System.console();
    cons.printf("\n");
    try {
      cons.printf("Введите фамилию: ");
      String name = cons.readLine();

      cons.printf("Введите свой возраст: ");
      // Введите ваш возраст
      String eingabe = cons.readLine();
      int alter = Integer.parseInt(eingabe);

      cons.printf("\n");
      cons.printf(" %d года (лет)?", alter);
      // Столько лет?
      cons.printf(" Вы не обманываете, г-н или г-жа %s?\n", name);
    }
    catch (NumberFormatException e) {
      System.err.println("\n Ошибка! \n" +
      " Невозможно выполнить преобразование к числовому типу.");
    }
  }
}
