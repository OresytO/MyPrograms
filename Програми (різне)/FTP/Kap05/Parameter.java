class Dummy {
  int wert;
}

class Beispiel {
  int wert;
  int machWas(double para1, Dummy para2) {
    para1 = 0;
    para2.wert = 50;
    return 0;
  }
}

public class Parameter {
  public static void main(String[] args) {
    System.out.println();

    Beispiel hugo = new Beispiel();
    Dummy uebergabe = new Dummy();
    int ergebnis;
    double wert = 10.5;
    uebergabe.wert = 100;
    System.out.println(" ��������� ����� �������: \t"
                   + wert + "\t" + uebergabe.wert);
    ergebnis = hugo.machWas(wert,uebergabe);
    System.out.println(" ��������� ����� ������: \t"
                   + wert + "\t" + uebergabe.wert);
  }
}
