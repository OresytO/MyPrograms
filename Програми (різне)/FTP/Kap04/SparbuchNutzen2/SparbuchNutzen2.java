// Компилируется только, если в текущем
// каталоге Sparbuch.class находится основной класс программы 
public class SparbuchNutzen2 {
  public static void main(String[] args) 
    { Sparbuch meinSparbuch = new Sparbuch(0,3); 
    meinSparbuch.einzahlen(10000);
    System.out.println();
    System.out.println(" Доход за 5 лет \n"); 
    System.out.println("\t без суммируемых процентов: " +
                 (int) meinSparbuch.ertrag(5)); 
    System.out.println("\t с суммируемыми процентами: " +
                 (int) meinSparbuch.ertragZ(5));
  }
}
