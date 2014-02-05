// ��������� ������� 
import java.awt.*;
import javax.swing.*;
import java.awt.event.*;
import java.util.*; 

class MeinCanvas extends Canvas {
  MeinCanvas() {
    setBackground(Color.red);
    setForeground(Color.black); 
  }

  public void paint(Graphics g) {
    super.paint(g);
    g.setColor(Color.red);
    g.fillOval(1,1,5,5);
  }
}
  

public class Swing_Applet extends JApplet {
  MeinCanvas m_malFlaeche;
  LinkedList<Alien> m_alienListe; 

  public Swing_Applet() {
    // �������� ���������� ������������
    setLayout(new BorderLayout());
    m_malFlaeche = new MeinCanvas();
    add("Center",m_malFlaeche);

    // ���������� �������������� ������� ��� ����
    m_malFlaeche.addMouseListener(new MeinMausAdapter());

    // ������������ ������ �������
    m_alienListe = new LinkedList<Alien>(); 
  }

  public void start() {
    Alien alien = new Alien(m_malFlaeche,10,10);
    alien.start();
    m_alienListe.add(alien);
    alien = new Alien(m_malFlaeche,200,50);
    alien.start();
    m_alienListe.add(alien);
  }

  void loescheListe() {
    // �������� �������� ������ �����������
    for(Alien alien : m_alienListe)  
      alien.interrupt();

    m_alienListe.clear();
  }

  public void stop() {
    loescheListe(); 
  }

  public void destroy() {
    loescheListe(); 
  }

  // MouseAdapter ��� ���������� �����.
  // ������ ������ ������� ���� ������� ����� �����
  class MeinMausAdapter extends MouseAdapter {
    public void mousePressed(MouseEvent e) {
      Alien neu = new Alien(m_malFlaeche,e.getX(),e.getY()); 
      neu.start(); 
      m_alienListe.add(neu);
    }
  }
}


class Alien extends Thread {
  Canvas m_anzeige;
  int m_xPos,m_yPos;
  int m_dx = 2;  // ������ ���� � ����������� x � y
  int m_dy = 2; 

  Alien(Canvas c,int x,int y) {
    m_anzeige = c;
    m_xPos = x;
    m_yPos = y;
  }

  public void run() {
    anzeigen(); // ������������� Alien � ��������� �������

    while(isInterrupted() == false) {
      bewegen();

      try { 
         sleep(20);
      } 
      catch(InterruptedException e) { 
         return; 
      }
    }
  }

  void anzeigen() {
    Graphics g = m_anzeige.getGraphics();
    g.fillOval(m_xPos, m_yPos, 20, 20);
    g.drawLine(m_xPos+10, m_yPos+10, m_xPos, m_yPos+20);
    g.drawLine(m_xPos+10, m_yPos+10, m_xPos+20, m_yPos+20);
    g.setColor(Color.green);
    g.fillOval(m_xPos+5, m_yPos+5, 4,4);
    g.fillOval(m_xPos+11 ,m_yPos+5, 4,4);
    g.dispose(); 
  }
 
  void bewegen() {
    int xNeu, yNeu;
    Dimension m;
    Graphics g;

    g = m_anzeige.getGraphics();
    m = m_anzeige.getSize();
    xNeu = m_xPos + m_dx;
    yNeu = m_yPos + m_dy;

    if(xNeu < 0) {
      xNeu = 0;
      m_dx = -m_dx;
    }
    if(xNeu + 20 >= m.width) {
      xNeu = m.width - 20;
      m_dx = -m_dx; 
    }
    if(yNeu < 0) {
      yNeu = 0;
      m_dy = -m_dy;       
    }
    if(yNeu + 20 >= m.height) {
      yNeu = m.height - 20;
      m_dy = -m_dy; 
    }


    g.setColor(m_anzeige.getBackground());
    g.fillRect(m_xPos-2, m_yPos-2, m_xPos+22, m_yPos+22);

    m_xPos = xNeu;
    m_yPos = yNeu;
    anzeigen();
    g.dispose();
  }
}

