public class ExceptionTest {
  public static void main(String[] args) {
    int i;
    int[] zahlen = new int[100]; System.out.println();
    // ����� ����� ����������� ������, ������� "����������� ������"
    try {
      for( i = 0; i<= 100; i++) {
        System.out.println("i ����� �������� " + i +"\n");
        zahlen[i] = i;
      }
    }
    // ����� ��������� ������
    catch(ArrayIndexOutOfBoundsException e) {
      System.err.println("����������� ������!\n");
    }
  }
}
