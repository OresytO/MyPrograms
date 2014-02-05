import java.io.*;

public class DateiLesen {
  public static void main(String[] args) throws IOException {
    FileReader eingabestream = new FileReader("john_maynard.txt");
    StringBuilder text = new StringBuilder(10);
    int gelesen;
    boolean ende = false;

    // Чтение символов до тех пор, пока не будет достигнут конец файла
    while(!ende) {
      gelesen = eingabestream.read();

      if(gelesen == -1)
        ende = true;
    else
      text.append( (char) gelesen);
    }
    System.console().printf("\n");
    System.console().printf(text.toString());

    eingabestream.close();
  }
}
