// ������ ��������� GUI � ���������� �������
import java.awt.*;
import java.awt.event.*;

public class GUI_Beispiel4 extends Frame {
  Button m_h�nsel, m_und, m_gretel;

  // ����������� ����������� ������� Adapter � Listener
  // ��� ���������� �������
  // ������ GUI_GBeispiel4
  class MeinWindowLauscher extends WindowAdapter {
    public void windowClosing(WindowEvent e) {
      // ����� �� ���������
      System.exit(0);
    }
  }
 
class MeinMouseLauscher implements MouseListener{
   public void mouseClicked(MouseEvent e){
      // einmal piepen
      java.awt.Toolkit.getDefaultToolkit().beep();
   }
   public void mouseEntered(MouseEvent e) {
   }
   public void mouseExited(MouseEvent e) {
   }
   public void mousePressed(MouseEvent e) {
   }
   public void mouseReleased(MouseEvent e) {
   }
}

  // ����������� ��������� ��� ������
  GUI_Beispiel4(String titel) {
    super(titel);

    // ������������ ������
    m_h�nsel = new Button("�������");
    m_und  = new Button("�");
    m_gretel = new Button("�������");


    // ��������� Layout-��������� ��� ���������� ������ � �������
    setLayout(new FlowLayout());

    // ���������� ������ � ������
    add(m_h�nsel);
    add(m_und);
    add(m_gretel);

    // ���������� �������������� ������� ��� ���� -  WindowListener
    addWindowListener(new MeinWindowLauscher());

    // ����������� ActionListener ��� ������.
    // ������ ��� ��������� ����� ���������. 
    // ������, ��������� ����� ������������ ������������.
    m_h�nsel.addMouseListener(new MeinMouseLauscher());
    m_und.addMouseListener(new MeinMouseLauscher());
    m_gretel.addMouseListener(new MeinMouseLauscher());
  }

  public static void main(String[] args) {
    // ���������� � �������� ���������� ������
    GUI_Beispiel4 fenster = new GUI_Beispiel4("GUI � ���������� �������");
    fenster.pack();
    fenster.setVisible(true);   
  }
}
