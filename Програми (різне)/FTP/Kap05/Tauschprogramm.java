class Punkt { // ��������� ����� �����, ����������������� ������������
              // x, y, z
  double x, y, z;
}

class Tauscher {
// ����� Tausher ��������� ����� ������������ x � y
// ��� ������ ����� � ������ koordinatenTausch.
// ���� ����� � �������� ��������� �������� ������ �����.
// ���������� ��� ������ ������ ���������� �������� ������ �� ������ liste

  void koordinatenTausch(Punkt[] pliste) {
    int i = 0;
    double tmp;

    for(i = 0; i < pliste.length; i++) {
      // x � y ����������
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
    // �������� ������ �����
    Punkt[] liste = new Punkt[3]; // ������ liste �������� ������
                                  // �� �������-����� (Punkt)
    // ������ �������������� ������ �����.
    // ������� ������� � ��� ������ ������  Punkt
    for(i = 0; i< liste.length; i++)
      liste[i] = new Punkt();

    // ��������� ��������� �����
    liste[0].x = 0.0;
    liste[0].y = 1.0;
    liste[1].x = 2.0;
    liste[1].y = 3.0;
    liste[2].x = 4.0;
    liste[2].y = 5.0;

    System.out.println("\n ����� ������������� ");
    for( i = 0; i < liste.length; i++) {
    System.out.println(" Liste[" + i + "] : x = " +
                liste[i].x + " y = " + liste[i].y);
    }
    // �������� ������� � ���������� ����� �� ������
    tausche.koordinatenTausch(liste);

    System.out.println("\n ����� ������");
    for( i = 0; i < liste.length; i++) {
      System.out.println(" Liste[" + i + "] : x = " +
                  liste[i].x + " y = " + liste[i].y);
    }
  }
}