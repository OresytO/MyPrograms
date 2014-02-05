// Malprogramm
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Malprogramm extends JFrame {
  MeineCanvas m_malflache;     // ���������� ������
  ButtonGroup m_formauswahl;   // ������ ��������������
  int m_Xpos, m_Ypos;          // ������� ������� ������� ����

  // � main() ��������� ��������� ������
  // � ��������� �� �������
  public static void main(String[] args) {
    Malprogramm fenster = new Malprogramm("������ �������������� ������");
    fenster.pack();
    fenster.setSize(450,350);
    fenster.setResizable(false);
    fenster.setVisible(true);
  }

  // � ������������ Malflache
  // ������� ������ ButtonGroup
  // � ���������� �������� ���������
  Malprogramm(String titel) {
    super(titel);

    // �������� ����������
    setLayout(new FlowLayout());

    // Die Malfl�che anlegen
    m_malflache = new MeineCanvas();
    add(m_malflache);

  // ���������� Panel-���������� ��� ������
  JPanel panel = new JPanel();
    // ������� � 3 �������� � 1 ��������
    panel.setLayout(new GridLayout(3,1,20,20));

    // ������������� ��� ������ �����
    m_formauswahl = new ButtonGroup();

    // 1. ��������� ��������������
    JRadioButton opt1 = new JRadioButton("����������",false);
    JRadioButton opt2 = new JRadioButton("����",false);
    JRadioButton opt3 = new JRadioButton("�������������",false);

    // 2. �������� ������ ��� ��������������
    opt1.setActionCommand("����������");
    opt2.setActionCommand("����");
    opt3.setActionCommand("�������������");

    // 3. ������������� � ������ ButtonGroup
    m_formauswahl.add(opt1);
    m_formauswahl.add(opt2);
    m_formauswahl.add(opt3);

    // 4. ������������� � ������
    panel.add(opt1);
    panel.add(opt2);
    panel.add(opt3);
     
    add(panel);
    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);   
  }


  class MeineCanvas extends Canvas {
    // ������� ������ ������ ��� ������� ���� 
    // ���������� ����� ������ 
    class MeinMausAdapter extends MouseAdapter {
      public void mousePressed(MouseEvent e) {
        // ����������� ������� ������� ����
        m_Xpos = e.getX();
        m_Ypos = e.getY();

        // ����������� ����
        repaint();
      }
    }

    // der Konstruktor implementiert die Mausbehandlung 
    // und setzt Hintergrund und Vordergrundfarbe
    MeineCanvas() {
      addMouseListener(new MeinMausAdapter());

      setBackground(Color.black);
      setForeground(Color.orange);
    }

    // �������� ����� ���������
    public void paint(Graphics g) {
      String label;
      ButtonModel aktuell = null;

      // ����� ������ �������?
      aktuell = m_formauswahl.getSelection();

      // ����������� � ������������ � ������������� �������
      if(aktuell == null)
        return;

      int w = (int) (Math.random()*300);
      int h = (int) (Math.random()*300);
      label = aktuell.getActionCommand();

      if(label.equals("����������"))
        g.drawOval(m_Xpos,m_Ypos,w,w);

      if(label.equals("����"))
        g.fillOval(m_Xpos,m_Ypos,w,h);

      if(label.equals("�������������"))
        g.drawRect(m_Xpos,m_Ypos,w,h);
    }

    // 
    public Dimension getMinimumSize() {
      return new Dimension(300,300);
    }

    // Die Lieblingsgr��e setzen wir auf die Minimalgr��e
    public Dimension getPreferredSize() {
      return getMinimumSize();
    }
  }  // ����� MeineCanvas 

} // ����� Malprogramm 
