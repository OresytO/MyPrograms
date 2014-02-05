// Улучшение Lotto.java: нет дубликатов
import java.util.*;
class Lotto2 {
  public static void main(String args[]) {
    boolean eingefuegt;
    int i, zahl, anzahl = 0;
    Random generator = new Random();
    HashSet<Integer> gezogen = new HashSet<Integer>();

    System.out.println("\n Выигрышные номера лотереи \n");

    while(true) {
      zahl = generator.nextInt(50);
      if(zahl == 0)       // 0 не нужен
        continue;

      // проверяют, вставлено ли число в множество
      // В случае отсутствия возможности -> генерируется новое число
      eingefuegt = gezogen.add(zahl);
      if(!eingefuegt)    // уже в наличии -> новая попытка
        continue;
      // Вывод числа
      System.out.println(" Выпало число: " + zahl);
      // Были ли представлены 6 чисел? Тогда конец.
      anzahl++;
      if(anzahl == 6)
        break;
    }
  }
}
