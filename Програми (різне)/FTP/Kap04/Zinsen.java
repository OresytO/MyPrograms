public class Zinsen {
  public static void main(String[] args) {
    double startkapital = 15000; // ��������� �������
    double zinssatz = 3.5;       // ���������� ������
    double laufzeit;             // �����
    double endkapital;           // �������������� �������
    // ���������� ��������� ��������
    System.out.println();
    endkapital = startkapital * Math.pow((1 + zinssatz/100),1);
    System.out.println(" ����� 1 ���:  " + (int)endkapital + " ����");
    endkapital = startkapital * Math.pow((1 + zinssatz/100),2);
    System.out.println(" ����� 2 ����: " + (int)endkapital + " ����");
    endkapital = startkapital * Math.pow((1 + zinssatz/100),3);
    System.out.println(" ����� 3 ����: " + (int)endkapital + " ����");
    endkapital = startkapital * Math.pow((1 + zinssatz/100),4);
    System.out.println(" ����� 4 ����: " + (int)endkapital + " ����");
    endkapital = startkapital * Math.pow((1 + zinssatz/100),5);
    System.out.println(" ����� 5 ���:  " + (int)endkapital + " ����");
    endkapital = startkapital * Math.pow((1 + zinssatz/100),6);
    System.out.println(" ����� 6 ���:  " + (int)endkapital + " ����");
    endkapital = startkapital * Math.pow((1 + zinssatz/100),7);
    System.out.println(" ����� 7 ���:  " + (int)endkapital + " ����");
  }
}
