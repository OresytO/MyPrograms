import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.awt.geom.*;

public class Malprogramm_2D extends JFrame {
  MeineCanvas m_malflache;      // Hier wird gezeichnet
  ButtonGroup m_formauswahl;    // liefert die zur Zeit ausgewählte Form
  int m_Xpos, m_Ypos;           // aktuelle Mausposition

  // In main wird eine Instanz der Klasse angelegt und auf den Bildschirm
  // gebracht
  public static void main(String[] args) {
    Malprogramm_2D fenster = new Malprogramm_2D("Ðèñóåì â Java2D");
    fenster.pack();
    fenster.setSize(400,350);
    fenster.setResizable(false);
    fenster.setVisible(true);
  }


  // Im Konstruktor wird eine anvas-Malfläche angelegt sowie  
  // eine ButtonGroup-Gruppe mit 
  // zur Auswahl stehenden Zeichenformen
  Malprogramm_2D(String titel) {
    super(titel);

    // Einen Layout-Manager anlegen
    setLayout(new FlowLayout());

    // Die Malfläche anlegen
    m_malflache = new MeineCanvas();
    add(m_malflache);

    // Panel-Container für Schaltflächen anlegen
    Panel panel = new Panel();
      // Gitter mit 3 Zeilen, 1 Spalte
      panel.setLayout(new GridLayout(3,1,20,20));

      // Optionsfelder zur Auswahl der Formen anlegen
      m_formauswahl = new ButtonGroup();

      // 1. Optionsfelder erzeugen
      JRadioButton opt1 = new JRadioButton ("Kreis",false);
      JRadioButton opt2 = new JRadioButton ("Scheibe",false);
      JRadioButton opt3 = new JRadioButton ("Rechteck",false); 
 
      // 2. Befehlsnamen für Optionsfelder festlegen
      opt1.setActionCommand("Kreis");
      opt2.setActionCommand("Scheibe");
      opt3.setActionCommand("Rechteck");

      // 3. Optionsfelder in ButtonGroup-Gruppe aufnehmen
      m_formauswahl.add(opt1);
      m_formauswahl.add(opt2);
      m_formauswahl.add(opt3);
 
      // 4. Optionsfelder in Panel aufnehmen
      panel.add(opt1);
      panel.add(opt2);
      panel.add(opt3);
     
    add(panel);
  
    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE); 
  }


  class MeineCanvas extends Canvas {
    // Die Adapter-Klasse für die Mausklicks  als innere Klasse
    // von Meine_anvas 
    class MeinMausAdapter extends MouseAdapter {
      public void mousePressed(MouseEvent e) {
        // Die aktuelle Position der Maus merken
        m_Xpos = e.getX();
        m_Ypos = e.getY();

        // Malfläche aktualisieren
        repaint();
      }
    }
  
    // der Konstruktor implementiert die Mausbehandlung und setzt
    // Hintergrund und Vordergrund (=Zeichen)farbe
    MeineCanvas() {
      addMouseListener(new MeinMausAdapter());

      setBackground(Color.black);
      setForeground(Color.orange);
    }

    // Die wichtigste Methode: hier wird gezeichnet!
    public void paint(Graphics g) {
      String label;
      ButtonModel aktuell = null;

      Graphics2D g_2d = (Graphics2D) g;

      // welche Form ist gerade ausgewählt?
      aktuell = m_formauswahl.getSelection();

      // entsprechend handeln
      if(aktuell == null)
        return;

      int w = (int) (Math.random()*300);
      int h = (int) (Math.random()*300);
      label = aktuell.getActionCommand();

      // die Attribute setzen 
      BasicStroke strich = new BasicStroke(2.0f,BasicStroke.CAP_BUTT,		
                                BasicStroke.JOIN_BEVEL);
      GradientPaint fuell = new GradientPaint(0.0f,0.0f,Color.red,
             			300.0f,300.0f,Color.yellow,true);
      g_2d.setStroke(strich);
      g_2d.setPaint(fuell);

      if(label.equals("Kreis")) {
	  Ellipse2D.Float oval = new Ellipse2D.Float((float) m_Xpos, (float) m_Ypos,
                                                   (float) w,(float) w);
  	  g_2d.draw(oval);
	}

      if(label.equals("Scheibe")) {
	  Ellipse2D.Float oval = new Ellipse2D.Float((float) m_Xpos,(float) m_Ypos,
                                                   (float) w,(float) w);
  	  g_2d.fill(oval);
	}

      if(label.equals("Rechteck")) {
	  Rectangle2D.Float rechteck= new Rectangle2D.Float((float) m_Xpos,(float) m_Ypos,
                                                          (float) w,(float) h);
  	  g_2d.draw(rechteck);
      }
    }

    // Diese Methode liefert die minimale Größe der anvas
    public Dimension getMinimumSize() {
      return new Dimension(300,300);
    }
    // Die Lieblingsgröße setzen wir auf die Minimalgröße
    public Dimension getPreferredSize() {
      return getMinimumSize();
    }
  }   

}  
