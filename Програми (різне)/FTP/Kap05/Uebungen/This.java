public class This  {
  public static void main(String[] args) {
    System.out.println();

    Demo_this inst = new Demo_this();
    System.out.println(" ��������� inst = " + inst);
    inst.this_wert();
  }
}

class Demo_this {
  void this_wert() {
    System.out.println(" this ����� �������� : " + this);
  }
}
