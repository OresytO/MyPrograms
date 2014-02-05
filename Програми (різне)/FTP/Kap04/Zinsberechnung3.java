public class Zinsberechnung3 {
  public static double zinsBerechnen(double startkapital,
                                     double zinssatz,
                                     double laufzeit) {
    double endkapital;

    // ������ ��������� �������� 
    endkapital = startkapital * Math.pow((1 + zinssatz/100),laufzeit);

    return endkapital;
  }

  public static void main(String[] args) {
    System.out.println();
    
    for(int laufzeit = 1; laufzeit < 8; laufzeit++)
      System.out.println(" ����� " + laufzeit + " ���: " 
               + (long) zinsBerechnen(15000,3.5,laufzeit)
               + " ����");
  }
}
