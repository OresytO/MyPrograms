import java.util.*;
import java.io.Console;
public class Tastatureingabe_Scanner {
  public static void main(String[] args) {
    Console cons = System.console();
    Scanner sc = new Scanner(System.console().reader());
    // Объект Scanner создается на основе console().reader()
    cons.printf("\n");
    try {
      cons.printf(" Введите фамилию: ");
      String name = sc.nextLine();

      // Объект sc считывает всю строку как string
      cons.printf(" Введите свой возраст: ");
      int alter = sc.nextInt();

      // Объект sc считывает очередной токен, как целое число
      cons.printf("\n");
      cons.printf(" %d года (лет)?", alter);
      cons.printf(" Вы не обманываете, г-н или г-жа %s?\n", name);
    }
    catch (InputMismatchException e) {
      System.err.println("\n Ошибка! \n" +
        " Невозможно выполнить преобразование к числовому типу.");
    }
  }
}
