// Реализация Runnable
 import java.util.Date;     
 import java.text.*;      
 import java.applet.*;
 import java.awt.*;

 public class Uhrzeit_Runnable extends Applet implements Runnable {
  String m_aktZeit;
  DateFormat m_formatierer;
  Thread m_zeit;
  Font m_anzeigeFont;

  public void init()  {
    m_anzeigeFont = new Font("Serif",Font.BOLD,22);
    m_formatierer = DateFormat.getTimeInstance();
    m_aktZeit = m_formatierer.format(new Date());

    // Создание и запуск дополнительного потока
    m_zeit = new Thread(this);
    m_zeit.start();
  }

  public void start()  {
    if(m_zeit == null) {
      m_zeit = new Thread(this);
      m_zeit.start();
    }
  }

  public void stop() {
    if(m_zeit != null)
      m_zeit = null; 
  }

  public void destroy() {
    if(m_zeit != null)
      m_zeit = null; 
  }

  public void paint(Graphics g)  {
    g.setFont(m_anzeigeFont);
    g.setColor(Color.blue);
    g.drawString(m_aktZeit,20,45);
  }

  // Метод run() потока
  public void run() {
    while(m_zeit == Thread.currentThread())   {
      m_aktZeit = m_formatierer.format(new Date());
      repaint();

      try {
        m_zeit.sleep(1000);
      }
      catch(InterruptedException e) {
        return;
      } 
    }
  }
}
