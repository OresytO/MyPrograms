// ���������� ���������� ��������� �����
import java.util.*;
class Lotto {
  public static void main(String args[]) {
    int zahl;
    int anzahl = 0;
    Random generator = new Random();
    System.out.println("\n ���������� ������ ������� \n");
    while(true) {
    // ����� ����� 0 (������������) � 50 (�������������)
      zahl = generator.nextInt(50);
      if(zahl == 0)
      // 0 �� �����
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
