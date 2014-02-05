import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

// �������� ���� Swing-������

public class FunkPlotter extends JFrame {
  MeineCanvas m_malflaeche;
  int aktFunktion = 0;  // ��� ���������� ����������
                        // ������������ �������;
                        // ��������� �������� 0 - ������� �����������

  public static void main(String[] args) {
    FunkPlotter fenster = new FunkPlotter("������ �������");
    fenster.pack();
    fenster.setSize(450,350);
    fenster.setResizable(false);
    fenster.setVisible(true);
  }

  // � ������������ ����� ������� ����� Canvas ��� ��������� �
  // ������ ��� ������ �������
  FunkPlotter(String titel) {
    super(titel);
    // �������� Layout-���������
    setLayout(new FlowLayout());

    // �������� � ���������� ������ ��� ���������
    m_malflaeche = new MeineCanvas();
    add(m_malflaeche);

    // �������� ������ � ���������� �� �� ������
    JButton f1 = new JButton("tan(x)");
    JButton f2 = new JButton("x^3");
    add(f1);
    add(f2);

    // ���������� ������� ��� ������
    class MeinActionLauscher implements ActionListener {
      public void actionPerformed(ActionEvent e) {
        String label;

        label = e.getActionCommand();

        if(label.equals("tan(x)"))
          aktFunktion = 1;
        else
          aktFunktion = 2;

        // ����� �����������
        m_malflaeche.repaint();
      }
    }

    // ���������� � ������� �������������� �������
    f1.addActionListener(new MeinActionLauscher());
    f2.addActionListener(new MeinActionLauscher());

    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
  }


 class MeineCanvas extends Canvas {
   // �����������
   MeineCanvas() {
     // ��������� ������� ����� ��� ����
     setBackground(Color.black);

     // ��������� �������� ����� ��� ��������� ����� (���� �������)
     setForeground(Color.green);
   }

     // ����� ������ �����, ����������� ���������
     public void paint(Graphics g) {
       double x,y;
       int xpos,ypos;

       // ����������� ������ ��������� � ����� �������
       g.translate(150,150);

       // ��������� ������������ ����
       g.setColor(Color.red);
       g.drawLine(0,-150,0,150);
       g.drawLine(-150,0,150,0);
       g.drawString("-3",-150,12);
       g.drawString("-3",4,147);
       g.drawString("+3",135,12);
       g.drawString("+3",4,-140);

       // ���� ����� ��� ��������� �������
       g.setColor(new Color(255,255,0));

       // ���� ������� ������� �� �������, ������ �� �����������
       if(aktFunktion == 0)
         return;

       for(x= -3.0; x<=3; x += 0.005) {
         if(aktFunktion == 1)
           y = Math.tan(x);
       else
         y = Math.pow(x,3);

       xpos = (int) (x*50);
       ypos = (int) (-y*50);

       g.fillOval(xpos,ypos,3,3);
     }
   }

   // ���� ����� ������������� ����������� ������� ������ Canvas
   public Dimension getMinimumSize() {
     return new Dimension(300,300);
   }

   // ��������� ���������������� �������� ������
   public Dimension getPreferredSize() {
     return getMinimumSize();
   }
 }


} // ����� ������ FunkPlotter
