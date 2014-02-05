// Woerter.java
import java.util.*;
import java.io.*;

class Woerter {
  public static void main(String []args) {
    Console cons = System.console();
    cons.printf("\n");

    cons.printf(" Введите текст: ");
    String eingabe = cons.readLine();

    StringTokenizer st = new StringTokenizer(eingabe);

    HashMap<String, Integer> hashTabelle
                      = new HashMap<String,Integer>();
    Integer ergebnis;
    int anzahl;
    String zeichenString;

    while(st.hasMoreTokens()) {
      zeichenString = st.nextToken();
      ergebnis = hashTabelle.get(zeichenString);
      if(ergebnis == null)
        hashTabelle.put(zeichenString, 1);
      else {
          anzahl = ergebnis.intValue() + 1;
          hashTabelle.put(zeichenString,anzahl);
        }
      }
      cons.printf(" Количество различных слов: %d \n",
                  hashTabelle.size());
      cons.printf("\n %s \n", hashTabelle);
  }
}
