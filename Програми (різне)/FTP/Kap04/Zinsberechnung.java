public class Zinsberechnung {
  public static void zinsBerechnen(double laufzeit) {
    double startkapital = 15000;  // стартовый капитал
    double zinssatz = 3.5;        // процентная ставка
    double endkapital;            // заключительный капитал

    // Вычисление конечного капитала
    endkapital = startkapital * Math.pow((1 + zinssatz/100),laufzeit);
    System.out.println(" Через " + (int) laufzeit + " года (лет): "
                       + (int) endkapital + " евро");
  }
  public static void main(String[] args) {
    System.out.println();
    zinsBerechnen(1);
    zinsBerechnen(2);
    zinsBerechnen(3);
    zinsBerechnen(4);
    zinsBerechnen(5);
    zinsBerechnen(6);
    zinsBerechnen(7);
  }
}
