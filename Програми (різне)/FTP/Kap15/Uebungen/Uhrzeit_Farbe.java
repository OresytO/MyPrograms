import java.util.Date;   
import java.text.*;      
import java.applet.*;
import java.awt.*;

public class Uhrzeit_Farbe extends Applet {
  String m_aktZeit;
  Color m_hinterGrundFarbe;
  DateFormat m_formatierer;
  ZeitThread m_zeit;
  FarbThread m_farbe;
  Font m_anzeigeFont;

  public void init()   {
    m_anzeigeFont = new Font("Serif",Font.BOLD,22);
    m_formatierer = DateFormat.getTimeInstance();
    m_aktZeit = m_formatierer.format(new Date());

    // Создание и запуск экземпляра Thread-класса
    m_zeit = new ZeitThread();
    m_zeit.start();
    m_farbe = new FarbThread();
    m_farbe.start();
  }

  public void start()   {
    // Запуск потока
    if(m_zeit == null) {
      m_zeit = new ZeitThread();
      m_zeit.start();
    }
    if(m_farbe == null) {
      m_farbe = new FarbThread();
      m_farbe.start();
    }
  }

  public void stop()   {
    // Окончание потока
    if(m_zeit != null) {
      m_zeit.interrupt();
      m_zeit = null;
    }
    if(m_farbe != null) {
      m_farbe.interrupt();
      m_farbe = null;
    }
  }

  public void destroy() {
    // Окончание потока
    if(m_zeit != null) {
      m_zeit.interrupt();
      m_zeit = null;
    }
    if(m_farbe != null) {
      m_farbe.interrupt();
      m_farbe = null;
    }
  }

  public void paint(Graphics g)  {
    // Отображение текущего времени
    setBackground(m_hinterGrundFarbe);
    g.setFont(m_anzeigeFont);
    g.setColor(Color.blue);
    g.drawString(m_aktZeit,20,45);
  }

  // den Thread als innere Klasse definieren
  class ZeitThread extends Thread {
    public void run()   {
      while(isInterrupted() == false) {
        m_aktZeit = m_formatierer.format(new Date());
        repaint();

        // kurze Zeit schlafen
        try {
          sleep(1000); 
        } 
        catch(InterruptedException e) {
          return;
        }
      }
    }
  }

  class FarbThread extends Thread {
    public void run()  {
      while(isInterrupted() == false)  {
        // Варьируются желтые тона
        m_hinterGrundFarbe = new Color(255, 255,
                                      (int)(255*Math.random()));
        repaint();
        try  {
           sleep(1000);
        }
        catch(InterruptedException e) {
           return; 
        }
      }
    }
  }

}
