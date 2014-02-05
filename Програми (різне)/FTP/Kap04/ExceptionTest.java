public class ExceptionTest {
  public static void main(String[] args) {
    int i;
    int[] zahlen = new int[100]; System.out.println();
    // здесь может встретиться ошибка, поэтому "установлена защита"
    try {
      for( i = 0; i<= 100; i++) {
        System.out.println("i имеет значение " + i +"\n");
        zahlen[i] = i;
      }
    }
    // здесь обработка ошибки
    catch(ArrayIndexOutOfBoundsException e) {
      System.err.println("Нелегальный доступ!\n");
    }
  }
}
