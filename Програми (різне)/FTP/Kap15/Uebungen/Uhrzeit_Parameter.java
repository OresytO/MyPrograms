import java.util.Date;   
import java.text.*;      
import java.applet.*;
import java.awt.*;

public class Uhrzeit_Parameter extends Applet {
  String m_aktZeit;
  DateFormat m_formatierer;
  ZeitThread m_zeit;
  Font m_anzeigeFont;

  public void init()   {
    String Parameter;
    Parameter = getParameter("Datum/Zeit");

    if (Parameter.equals("Zeit"))
       m_formatierer = DateFormat.getTimeInstance();
    else
       m_formatierer = DateFormat.getDateInstance();

    m_anzeigeFont = new Font("Serif",Font.BOLD,22);
    m_aktZeit = m_formatierer.format(new Date());

    // Создание и запуск экземпляра Thread-класса
    m_zeit = new ZeitThread();
    m_zeit.start();
  }

  public void start()   {
    // Запуск потока
    if(m_zeit == null) {
      m_zeit = new ZeitThread();
      m_zeit.start();
    }
  }

  public void stop() {
    // Окончание потока
    if(m_zeit != null) {
      m_zeit.interrupt();
      m_zeit = null;
    }
  }

  public void destroy() {
    // Окончание потока
    if(m_zeit != null) {
      m_zeit.interrupt();
      m_zeit = null;
    }
  }

  public void paint(Graphics g) {
    // 
    g.setFont(m_anzeigeFont);
    g.setColor(Color.blue);
    g.drawString(m_aktZeit,20,45);
  }

  // 
  class ZeitThread extends Thread {
    public void run()  {
      while(isInterrupted() == false) {
        m_aktZeit = m_formatierer.format(new Date());
        repaint();

        // 
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
