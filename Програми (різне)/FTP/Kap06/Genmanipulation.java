import java.io.*;
public class Genmanipulation {
  public static void main(String[] args) throws IOException {
    Console cons = System.console();
    cons.printf("\n");
    StringBuilder gencode = new StringBuilder(
                  "GUG-CAU-CUU-ACG-CCC-GUG-GAG-AAG");
    cons.printf(" До операции \n");
    cons.printf(" Генетический код = %s \n", gencode);
    // Вмешательство: символы в позиции 21 изменяются
    gencode.setCharAt(21,'A');
    cons.printf("\n");
    cons.printf(" После операции \n");
    cons.printf(" Генетический код = %s \n", gencode); }
}
