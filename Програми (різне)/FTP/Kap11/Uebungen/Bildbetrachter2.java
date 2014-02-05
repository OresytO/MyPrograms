// Bildbetrachter
import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class Bildbetrachter2 extends JFrame {
  static Bildbetrachter2 m_fenster;
  String  m_dateiname;           // ��� �����
  Image   m_aktBild;             // ������ ��� ����������� �������
  BildLeinwand m_bildanzeige;    // JPanel - ���� ����������
  int m_Xpos,m_Ypos;             // �������, � ������� 
                                 // ��������� ����� ������� 
                                 // ���� �����������
  int m_bild_x1,m_bild_y1;       // ������� ���������� 
  int m_bild_x2,m_bild_y2;       // �����������
  int m_bildHoehe,m_bildBreite;  // ������ � ������ � ��������

  // Ereignisbehandlung
  class MeinActionLauscher implements ActionListener {
    public void actionPerformed(ActionEvent e) {
      String Label;

      Label = e.getActionCommand();

      if(Label.equals("�������"))
         System.exit(0);

      if(Label.equals("��������� �����������"))
         bildLaden();         
      }
    }

  // � ������������ ����������� Panel (��� �������
  // ��� ����������� �������) � ������� ����
  Bildbetrachter2(String titel) {
    super(titel);

    m_Xpos = m_Ypos = 0;       // ������� �������: ����� ������
    m_bild_x1 = m_bild_x2 = m_bild_y1 = m_bild_y2 = 0;

    // ������� ������� ����������� �� ���������
    m_dateiname = null;
    m_aktBild = null;

    // ����������� Layout-���������
    setLayout(new FlowLayout());

    // �������� ������ (������������ �� JPanel)
    m_bildanzeige  = new BildLeinwand();
    add(m_bildanzeige);
  
    // ����������� ���� �������� ����
    JMenuBar menueleiste = new JMenuBar();
    setJMenuBar(menueleiste);

    // �������� ������������ ���� � ������� ����
    JMenu menu1 = new JMenu("����");
    JMenuItem item1  = new JMenuItem("��������� �����������");
    item1.addActionListener(new MeinActionLauscher());

    JMenuItem item2 = new JMenuItem("�������");
    item2.addActionListener(new MeinActionLauscher());
    menu1.add(item1);
    menu1.add(item2);
    menueleiste.add(menu1);

    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
  }

  // �������� ����� � ������������
  public void bildLaden(){
    FileDialog d = new FileDialog(this,"�������� �����������...",
                                  FileDialog.LOAD);
    d.setVisible(true);
    m_dateiname = d.getDirectory();
    m_dateiname += d.getFile();

    // ���� ������������ �� ������ ���� c ��������,
    // �� ����� ��������� null.
    // ����� ������� ���������� �������� �� ���������.
    if(m_dateiname == null)
       return;

    // �������� ������� 
    ImageIcon tmp = new ImageIcon(m_dateiname);
    m_aktBild = tmp.getImage(); 

    // ��������� ������ � ������ �������
    m_bildBreite = m_aktBild.getWidth(m_bildanzeige);
    m_bildHoehe = m_aktBild.getHeight(m_bildanzeige);

    m_bild_x1 = m_Xpos;
    m_bild_y1 = m_Ypos;
    m_bild_x2 = m_bild_x1 + m_bildBreite;
    m_bild_y2 = m_bild_y1 + m_bildHoehe;

    m_bildanzeige.repaint();
  }

  public static void main(String[] args) {
    m_fenster = new Bildbetrachter2("�������� �����������");
    m_fenster.setSize(800,700);
    m_fenster.pack();
    m_fenster.setVisible(true);
  }


  // ���� ����� ������ ��� ��������������� �����������
  class BildLeinwand extends JPanel {

    // ��������� ����� ������
    public void paintComponent(Graphics g) {
      super.paintComponent(g);

      // ���� ����������� ���������, �� ��� ������������
      if(m_aktBild != null)
        g.drawImage(m_aktBild,m_Xpos,m_Ypos,this);
    }

    public Dimension getMinimumSize() {
      return m_fenster.getSize();
    }
    public Dimension getPreferredSize() {
      return getMinimumSize();
    }
  }
}
