class IchZaehlMich {
  int        m_instanzvariable = 0;
  static int m_klassenvariable = 0;

  IchZaehlMich() {
    m_instanzvariable++;
    m_klassenvariable++;
    System.out.print(" Переменная экземпляра = " + m_instanzvariable);
    System.out.println("\t Переменная класса  = " + m_klassenvariable);
  }
 
  protected void finalize() {
    m_klassenvariable--;
    System.out.println(" Переменная класса = " +  m_klassenvariable);
  }
}

public class Instanzenzaehler  {
  static void erzeugeInstanzen() {
    IchZaehlMich instanz_1 = new IchZaehlMich(); 
    IchZaehlMich instanz_2 = new IchZaehlMich(); 
    IchZaehlMich instanz_3 = new IchZaehlMich(); 
  }

  public static void main(String[] args) 
                        throws InterruptedException  {
    System.out.println("\n Производные экземпляра: \n");
    erzeugeInstanzen();

    System.out.println("\n Частный случай: \n");
    System.gc();
    System.runFinalization();   
  }
}