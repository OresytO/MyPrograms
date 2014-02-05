class IchZaehlMich {
  int        m_instanzvariable = 0;
  static int m_klassenvariable = 0;
  IchZaehlMich() {
    m_instanzvariable++;
    m_klassenvariable++;
    System.out.print(" ���������� ���������� = " + m_instanzvariable);
    System.out.println("\t ���������� ������ = " + m_klassenvariable);
  }

  protected void finalize() {
    m_klassenvariable--;
    System.out.println(" ���������� ������ = " + m_klassenvariable);
  }
}
  public class Instanzenzaehler {
    static void erzeugeInstanzen() {
    IchZaehlMich instanz_1 = new IchZaehlMich();
    IchZaehlMich instanz_2 = new IchZaehlMich();
    IchZaehlMich instanz_3 = new IchZaehlMich();
  }

  public static void main(String[] args)
                          throws InterruptedException {
    System.out.println("\n ����������� ����������: \n");
    erzeugeInstanzen();

    System.out.println("\n ������� ������: \n");
    System.gc();
    System.runFinalization();
  }
}
