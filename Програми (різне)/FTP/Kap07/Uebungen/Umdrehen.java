  import java.util.*;
  import java.io.*;

  class Umdrehen {
    public static void main(String [] args) {
    Console cons = System.console();
    cons.printf("\n");

    cons.printf(" Введите текст: ");
    String eingabeWort = cons.readLine();

int anzahl = eingabeWort.length();

// Вставка букв в стековую память
    Stack<Character> keller = new Stack<Character>();
    for(int i = 0; i < anzahl; i++) {
      keller.push(eingabeWort.charAt(i));
    }

    // Извлечение и вывод элементов из стека
    cons.printf(" Получилось: ");
    for(int i = 0; i < anzahl; i++) {
      cons.printf("%s", keller.pop());
    }

    cons.printf("\n");
  }
}
