// ���� AWT_zu_Swing2.java
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
// ����������� ������ ����
public class AWT_zu_Swing2 extends JFrame {
   JButton schalter;

  // ��������� ������� �� ��������� ����������
  class MeinActionLauscher implements ActionListener {
    public void actionPerformed(ActionEvent e) {
      schalter.setText("�������");
    }
  }

  // �����������
  AWT_zu_Swing2(String titel) {
    super(titel);

    // �������� ������
    schalter = new JButton("����� ����");

    // ���������� ������ � ����
    add(schalter);

    // �������� ���� - �������� ����������
    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);

    // ���������� �������������� ActionListener ��� ������
    schalter.addActionListener(new MeinActionLauscher());
  }
  public static void main(String[] args) {
    AWT_zu_Swing2 fenster = new AWT_zu_Swing2("Swing");
    fenster.pack();
    fenster.setSize(300,100);
    fenster.setVisible(true);
  }
}
