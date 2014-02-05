// Функционирующий Uhrzeit-апплет
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
    // Отображение текущего времени
    g.setFont(m_anzeigeFont);
    g.setColor(Color.blue);
    g.drawString(m_aktZeit,20,45);
  }

  // Определение Thread как внутреннего класса
  class ZeitThread extends Thread {
    public void run()  {
      while(isInterrupted() == false) {
        m_aktZeit = m_formatierer.format(new Date());
        repaint();

        // Небольшое время задержки (на 1 секунду)
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
