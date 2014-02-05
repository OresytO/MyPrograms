public class Zinsen {
  public static void main(String[] args) {
    double startkapital = 15000; // стартовый капитал
    double zinssatz = 3.5;       // процентная ставка
    double laufzeit;             // время
    double endkapital;           // заключительный капитал
    // Вычисление конечного капитала
    System.out.println();
    endkapital = startkapital * Math.pow((1 + zinssatz/100),1);
    System.out.println(" Через 1 год:  " + (int)endkapital + " евро");
    endkapital = startkapital * Math.pow((1 + zinssatz/100),2);
    System.out.println(" Через 2 года: " + (int)endkapital + " евро");
    endkapital = startkapital * Math.pow((1 + zinssatz/100),3);
    System.out.println(" Через 3 года: " + (int)endkapital + " евро");
    endkapital = startkapital * Math.pow((1 + zinssatz/100),4);
    System.out.println(" Через 4 года: " + (int)endkapital + " евро");
    endkapital = startkapital * Math.pow((1 + zinssatz/100),5);
    System.out.println(" Через 5 лет:  " + (int)endkapital + " евро");
    endkapital = startkapital * Math.pow((1 + zinssatz/100),6);
    System.out.println(" Через 6 лет:  " + (int)endkapital + " евро");
    endkapital = startkapital * Math.pow((1 + zinssatz/100),7);
    System.out.println(" Через 7 лет:  " + (int)endkapital + " евро");
  }
}
