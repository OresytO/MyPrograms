import java.io.*;
public class Genmanipulation {
  public static void main(String[] args) throws IOException {
    Console cons = System.console();
    cons.printf("\n");
    StringBuilder gencode = new StringBuilder(
                  "GUG-CAU-CUU-ACG-CCC-GUG-GAG-AAG");
    cons.printf(" �� �������� \n");
    cons.printf(" ������������ ��� = %s \n", gencode);
    // �������������: ������� � ������� 21 ����������
    gencode.setCharAt(21,'A');
    cons.printf("\n");
    cons.printf(" ����� �������� \n");
    cons.printf(" ������������ ��� = %s \n", gencode); }
}
