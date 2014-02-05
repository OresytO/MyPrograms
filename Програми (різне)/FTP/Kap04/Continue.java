public class Continue {
  public static void main(String[] args) {
    int i;
    System.out.println();
    for(i = 0 ; i< 1000; i++) {
      if ( i != 500)
        continue;
      System.out.println("i имеет значение 500!");
    }
  }
}
