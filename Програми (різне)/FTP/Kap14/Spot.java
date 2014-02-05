// Datei Spot 
// Генератор кружков
import java.awt.*;
import java.applet.*;

public class Spot extends Applet {
  class Scheibe {
    int m_x, m_y; // цент кружка
    int m_r;      // радиус кружка
  }

  Scheibe[] m_flecken;
  Color m_farbe;


  public Spot() {
    m_flecken = new Scheibe[7];
    for(int i = 0; i < m_flecken.length; i++) {
       m_flecken[i] = new Scheibe();
    }
  }

  public void init() {
    // Установка цвета
    m_farbe = new Color((int) (255*Math.random()),
                        (int) (255*Math.random()),
                        (int) (255*Math.random()) );
  }


  public void start() {
    // Задание центров и радиусов кружков
    for(int i = 0; i < m_flecken.length; i++) {
       m_flecken[i].m_x = (int) (400*Math.random()); 
       m_flecken[i].m_y = (int) (200*Math.random()); 
       m_flecken[i].m_r = (int) (50*Math.random());
    }
  }


  public void paint(Graphics g) {
    g.setColor(m_farbe);
    for(int i = 0; i < m_flecken.length; i++) {
       g.fillOval(m_flecken[i].m_x, 
                  m_flecken[i].m_y, 
                  m_flecken[i].m_r, 
                  m_flecken[i].m_r);
    }
  }
} // Конец Spot
