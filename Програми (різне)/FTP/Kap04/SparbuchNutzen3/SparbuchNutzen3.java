import zinsrechnung.Sparbuch;

// �������� ����� ���������
public class SparbuchNutzen3 {

  public static void main(String[] args)  {
    Sparbuch meinSparbuch = new Sparbuch(0,3);
    meinSparbuch.einzahlen(10000);
    
    System.out.println();
    System.out.println(" ����� �� 5 ��� : \n");
    System.out.println("\t ��� ����������� ���������: " + 
                 (int) meinSparbuch.ertrag(5));
    System.out.println("\t � ������������ ����������: " + 
                 (int) meinSparbuch.ertragZ(5));
  }
}
