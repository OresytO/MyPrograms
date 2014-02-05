// ��������������� Uhrzeit-������
import java.util.Date;   
import java.text.*;      
import java.applet.*;
import java.awt.*;

public class Uhrzeit extends Applet {
  String m_aktZeit;
  DateFormat m_formatierer;
  ZeitThread m_zeit;
  Font m_anzeigeFont;

  public void init()   {
    m_anzeigeFont = new Font("Serif",Font.BOLD,22);
    m_formatierer = DateFormat.getTimeInstance();
    m_aktZeit = m_formatierer.format(new Date());

    // �������� � ������ ���������� Thread-������
    m_zeit = new ZeitThread();
    m_zeit.start();
  }

  public void start()   {
    // ������ ������
    if(m_zeit == null) {
      m_zeit = new ZeitThread();
      m_zeit.start();
    }
  }

  public void stop() {
    // ��������� ������
    if(m_zeit != null) {
      m_zeit.interrupt();
      m_zeit = null;
    }
  }

  public void destroy() {
    // ��������� ������
    if(m_zeit != null) {
      m_zeit.interrupt();
      m_zeit = null;
    }
  }

  public void paint(Graphics g) {
    // ����������� �������� �������
    g.setFont(m_anzeigeFont);
    g.setColor(Color.blue);
    g.drawString(m_aktZeit,20,45);
  }

  // ����������� Thread ��� ����������� ������
  class ZeitThread extends Thread {
    public void run()  {
      while(isInterrupted() == false) {
        m_aktZeit = m_formatierer.format(new Date());
        repaint();

        // ��������� ����� �������� (�� 1 �������)
        try {
          sleep(1000); 
        } 
        catch(InterruptedException e)  {
          return;
        }
      }
    }
  }
}
