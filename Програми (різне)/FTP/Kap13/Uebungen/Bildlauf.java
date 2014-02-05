import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.event.*;

// Fensterklasse definieren
public class Bildlauf extends JFrame {

  // ����������� 
  Bildlauf(String titel) {
    super(titel);
  
    // �������� ���������� GridBagLayout
    GridBagLayout gridbag = new GridBagLayout();   
    setLayout(gridbag);

    //Constraint-Objekt f�r Layout-Manager anlegen
    GridBagConstraints constraints = new GridBagConstraints();

    //Constraint-Objekt einrichten
 
    //Komponenten an Zellengr��e anpassen
    constraints.fill = GridBagConstraints.BOTH;

    //Abst�nde um Zellen  angeben
    constraints.insets.top = 20;
    constraints.insets.bottom = 5;
    constraints.insets.left = 20;
    constraints.insets.right = 20;

    // Label einrichten
    JLabel text = new JLabel("    ������ ���������:    ",SwingConstants.LEFT);

    // Letzte Zelle in dieser Reihe
    constraints.gridwidth = GridBagConstraints.REMAINDER;
    // Constraint-Einstellungen mit Label verbinden
    gridbag.setConstraints(text,constraints);
    add(text);

    // Bildlaufleiste einrichten
    JScrollBar bildlauf = new JScrollBar(SwingConstants.HORIZONTAL,4,1,0,10);

    constraints.gridwidth = GridBagConstraints.REMAINDER;
    // Abst�nde um Zelle neu setzen 
    constraints.insets.top = 5;
    constraints.insets.bottom = 20;
    // Constraint-Einstellungen mit ScrollBar verbinden
    gridbag.setConstraints(bildlauf,constraints);
    add(bildlauf);
    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
  }


  public static void main(String[] args) {
    Bildlauf fenster = new Bildlauf("����������");
    fenster.pack();
    fenster.setSize(300,100);
    fenster.setResizable(false);
    fenster.setVisible(true);
  }
}
