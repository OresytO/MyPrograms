public class Zinsberechnung {
  public static void zinsBerechnen(double laufzeit) {
    double startkapital = 15000;  // ��������� �������
    double zinssatz = 3.5;        // ���������� ������
    double endkapital;            // �������������� �������

    // ���������� ��������� ��������
    endkapital = startkapital * Math.pow((1 + zinssatz/100),laufzeit);
    System.out.println(" ����� " + (int) laufzeit + " ���� (���): "
                       + (int) endkapital + " ����");
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
