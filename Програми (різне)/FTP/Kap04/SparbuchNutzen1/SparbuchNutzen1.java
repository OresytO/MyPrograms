class Sparbuch { 
    double kapital; 
    double zinssatz;

    Sparbuch(double kap, double zins) {
      kapital = kap;
      zinssatz = zins;
    }

    void einzahlen(double betrag) {
kapital += betrag;
    }

    void abheben(double betrag) {
      kapital -= betrag;
    }

  double ertragZ(double laufzeit) {
    return kapital *
           Math.pow((1 + zinssatz/100),laufzeit);
}

  double ertrag(double laufzeit) {
    return kapital * (1 + zinssatz/100 * laufzeit);
  }
}

//�������� ����� ���������
class SparbuchNutzen1 {
  public static void main(String[] args) 
    { Sparbuch meinSparbuch = new Sparbuch(0,3); 
    meinSparbuch.einzahlen(10000);
    System.out.println();
    System.out.println(" ����� �� 5 ��� : \n"); 
    System.out.println("\t ��� ������� ���������: " +
                      (int) meinSparbuch.ertrag(5)); 
    System.out.println("\t �� �������� ����������: " +
                     (int) meinSparbuch.ertragZ(5));
  }
}
