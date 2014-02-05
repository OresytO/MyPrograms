// ���� AWT_zu_Swing1.java
import java.awt.*;
import java.awt.event.*;

// ����������� ������ ����
public class AWT_zu_Swing1 extends Frame {
  Button schalter;

  // ������� ��������� ������� ��� ����
  class MeinWindowLauscher extends WindowAdapter {
    public void windowClosing(WindowEvent e) {
      System.exit(0);
    }
  }
  // ��������� ������� ��� ��������� ����������
  class MeinActionLauscher implements ActionListener {
    public void actionPerformed(ActionEvent e) {
      schalter.setLabel("�������");
    }
  }

  // �����������
  AWT_zu_Swing1(String titel) {
    super(titel);

    // ������������ ������
    schalter = new Button("����� ����");

    // ������� ������ � ����
    add(schalter);
    // �������� ���� - �������� ����������
    addWindowListener(new MeinWindowLauscher());

    // ����������� ������ � ActionListener
    schalter.addActionListener(new MeinActionLauscher());
  }

  public static void main(String[] args) {
    AWT_zu_Swing1 fenster = new AWT_zu_Swing1("AWT");
    fenster.pack();
    fenster.setSize(300,100);
    fenster.setVisible(true);
  }
}
