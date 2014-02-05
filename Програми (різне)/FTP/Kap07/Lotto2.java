// ��������� Lotto.java: ��� ����������
import java.util.*;
class Lotto2 {
  public static void main(String args[]) {
    boolean eingefuegt;
    int i, zahl, anzahl = 0;
    Random generator = new Random();
    HashSet<Integer> gezogen = new HashSet<Integer>();

    System.out.println("\n ���������� ������ ������� \n");

    while(true) {
      zahl = generator.nextInt(50);
      if(zahl == 0)       // 0 �� �����
        continue;

      // ���������, ��������� �� ����� � ���������
      // � ������ ���������� ����������� -> ������������ ����� �����
      eingefuegt = gezogen.add(zahl);
      if(!eingefuegt)    // ��� � ������� -> ����� �������
        continue;
      // ����� �����
      System.out.println(" ������ �����: " + zahl);
      // ���� �� ������������ 6 �����? ����� �����.
      anzahl++;
      if(anzahl == 6)
        break;
    }
  }
}
