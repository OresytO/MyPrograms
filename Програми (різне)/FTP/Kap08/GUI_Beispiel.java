import java.awt.*;

public class GUI_Beispiel extends Frame{
  // ����������� ��������� ��� ������
  GUI_Beispiel(String titel) {
    super(titel);	// ��������� ����
    // ������������ ������
    Button hansel = new Button("�������");
    Button und	= new Button("�");
    Button gretel = new Button("�������");

    // ��������� Layout-��������� ��� ���������� ������
    setLayout(new FlowLayout());

    // ���������� ������ � ����
    add(hansel);
    add(und);
    add(gretel);
  }

  public static void main(String[] args) {
    // �������� ���������� �������� ������
    GUI_Beispiel fenster =
      new GUI_Beispiel("������ GUI-���������");

    fenster.pack();
    fenster.setVisible(true);
  }
}
