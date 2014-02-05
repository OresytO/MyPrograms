class Punkt { // объявляем класс точек, характеризующихся координатами
              // x, y, z
  double x, y, z;
}

class Tauscher {
// Класс Tausher выполняет обмен координатами x и y
// для данной точки в методе koordinatenTausch.
// Этот метод в качестве параметра получает массив точек.
// Фактически при вызове метода передается адресная ссылка на массив liste

  void koordinatenTausch(Punkt[] pliste) {
    int i = 0;
    double tmp;

    for(i = 0; i < pliste.length; i++) {
      // x и y заменяются
      tmp = pliste[i].x;
      pliste[i].x =
      pliste[i].y;
      pliste[i].y = tmp;
   }
  }
}
public class Tauschprogramm {
  public static void main(String[] args) {
    int i;
    Tauscher tausche = new Tauscher();
    // Создание массив точек
    Punkt[] liste = new Punkt[3]; // Массив liste содержит ссылки
                                  // на объекты-точки (Punkt)
    // Теперь инициализируем массив точек.
    // Элемент массива — это объект класса  Punkt
    for(i = 0; i< liste.length; i++)
      liste[i] = new Punkt();

    // Установка координат точек
    liste[0].x = 0.0;
    liste[0].y = 1.0;
    liste[1].x = 2.0;
    liste[1].y = 3.0;
    liste[2].x = 4.0;
    liste[2].y = 5.0;

    System.out.println("\n После инициализации ");
    for( i = 0; i < liste.length; i++) {
    System.out.println(" Liste[" + i + "] : x = " +
                liste[i].x + " y = " + liste[i].y);
    }
    // Передача массива в вызываемый метод по ссылке
    tausche.koordinatenTausch(liste);

    System.out.println("\n После замены");
    for( i = 0; i < liste.length; i++) {
      System.out.println(" Liste[" + i + "] : x = " +
                  liste[i].x + " y = " + liste[i].y);
    }
  }
}