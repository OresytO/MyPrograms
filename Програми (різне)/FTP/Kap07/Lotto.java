// Применение генератора случайных чисел
import java.util.*;
class Lotto {
  public static void main(String args[]) {
    int zahl;
    int anzahl = 0;
    Random generator = new Random();
    System.out.println("\n Выигрышные номера лотереи \n");
    while(true) {
    // Число между 0 (включительно) и 50 (исключительно)
      zahl = generator.nextInt(50);
      if(zahl == 0)
      // 0 не нужен
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
