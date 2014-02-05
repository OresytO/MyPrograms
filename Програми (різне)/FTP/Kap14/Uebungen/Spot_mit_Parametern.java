// Der Fleckengenerator mit Parameter
import java.awt.*;
import java.applet.*;

public class Spot_mit_Parametern extends Applet {
  class Scheibe {
    int m_x, m_y; // Mittelpunkt
    int m_r;      // Radius
  }

  Scheibe[] m_flecken;
  Color m_farbe;


  public Spot_mit_Parametern() {
  }

  public void init() {
     String parameter = getParameter("Number");
     int anzahl = Integer.parseInt(parameter);
     m_flecken = new Scheibe[anzahl];
     for(int i = 0; i < m_flecken.length; i++) 
       m_flecken[i] = new Scheibe();

     String farbe = getParameter("ColorSpot").toUpperCase();
     if (farbe.equals("RED"))
        m_farbe = new Color (255, 0, 0);
     else if (farbe.equals("BLUE"))
        m_farbe = new Color (0, 0, 255);
     else if (farbe.equals("GREEN"))
        m_farbe = new Color (0, 255, 0);
     else if (farbe.equals("YELLOW"))
        m_farbe = new Color (255, 255, 0);
     else 
        m_farbe = new Color (0, 0, 0);
  }


  public void start() {
    //Mittelpunkte und Radien festlegen
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
} 
