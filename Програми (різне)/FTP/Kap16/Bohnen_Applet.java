// ��������� ����
import java.awt.*;
import java.net.*;
import java.applet.*;
import java.awt.event.*;

public class Bohnen_Applet extends Applet
                            implements Runnable {
  Thread       m_bohne;
  AudioClip    m_klang;      // ������� ������
  MediaTracker m_tracker;    // �������������� �������� �����������
  Image[]      m_bilderfeld = new Image[11];   // �����������
  int          m_aktBild ;  // ������ �����������, �������
                            // ������ ������������
  int m_bildH�he;       
  int m_bildBreite;


  public void init() {
    URL Codebase;

    // ������-����� ���� ����
    setBackground(Color.lightGray);

    Codebase = getCodeBase();
    m_tracker = new MediaTracker(this);

    // �������� ��������� �����
    m_klang = getAudioClip(Codebase,"spacemusic.au");

    // �������� ��������� ������, ������� ������
    // ��� �������������� �����; ����������� � �������

    for(int i=1; i<= 10; i++)  {
      m_bilderfeld[i]= getImage(Codebase,"T"+i+".gif");

      // ���������� ���� ����������� � MediaTracker
      m_tracker.addImage(m_bilderfeld[i],1);
    }

    // ���������� ��������
    try  {
       m_tracker.waitForAll();
       m_aktBild = 1;
    }
    catch(InterruptedException e) {
       return;
    }
  }
  

  public void start() {
    // ������ ������
    if(m_bohne == null) {
      m_bohne = new Thread(this);
      m_bohne.start();

      // ��������������� ����� � ����������� �����
      if(m_klang != null)
         m_klang.loop();
    }
  }

  public void stop() {
    // ��������� ������
    if(m_bohne != null) {
      m_bohne = null;
    }

    // ��������� ��������������� �����
    if(m_klang != null)
        m_klang.stop();
  }

  public void destroy() {
    // ��������� ������
    if(m_bohne != null) {
      m_bohne = null;
    }

    // ��������� ��������������� �����
    if(m_klang != null)
        m_klang.stop();
  }

  // ����� run() ������ ��������� ������ �������!
  public void run()  {
    while(m_bohne == Thread.currentThread())  {
      // �������� ������� ������� �����������, ����� � paint()
      // ���� ����������� �������� ��������������� �����
      m_bildBreite = m_bilderfeld[m_aktBild].getWidth(this);
      m_bildH�he =   m_bilderfeld[m_aktBild].getHeight(this);

      m_aktBild++;       // ������ �����������
      if(m_aktBild > 10)
        m_aktBild = 1;

      repaint();         // ... � �����
      try {
        m_bohne.sleep(200);
        if(m_aktBild == 10)
           m_bohne.sleep(500);
      }
      catch(InterruptedException e)  {
        return;
      }                                                                            
    }
  }

  // ���������� update(), ����� �� ���� �������
  // �������� �������� ����� ������� paint()
  public void update(Graphics g) {
    paint(g);
  }

  // ����� ������������ ��������
  public void paint(Graphics g) {
    // ���� ����������� �� ���������, �� ������� ��������
    if(!m_tracker.checkAll())
        return;

    // �������� ���������� �����������
    g.setColor(Color.lightGray);
    g.fillRect(0,0,m_bildBreite,m_bildH�he);

    // ����� ������ �����������
    g.drawImage(m_bilderfeld[m_aktBild], 0, 0,this);
  }
} // ����� ������ Bohnen_Applet 
