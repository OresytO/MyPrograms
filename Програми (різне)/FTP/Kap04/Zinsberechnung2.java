public class Zinsberechnung2 {
  public static double zinsBerechnen(double startkapital, 
                                     double zinssatz, 
                                     double laufzeit) {
    double endkapital;
// ������ ��������� �������� 
    endkapital = startkapital *
    Math.pow((1 + zinssatz/100),laufzeit);
    return endkapital;
  }
public static void main(String[] args) {
  double endkapital;
    endkapital = zinsBerechnen(15000, 3.5, 7);

    System.out.println();
    System.out.println(" ����� ������ ����� 7 ���: "
                       + (int) endkapital);
  }
}


