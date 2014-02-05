import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

// Fensterklasse definieren
public class Icon extends JFrame {
  JButton m_schalter;

  // der Konstruktor 
  Icon(String titel) {
    super(titel);

    setLayout(new BorderLayout());
    ImageIcon icon = new ImageIcon("buttonImage.gif");
    m_schalter =  new JButton("Нажми меня", icon);
    add(m_schalter);

    // Lauscher einrichten
    m_schalter.addActionListener(new MeinActionLauscher());

    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE); 
  }


  // Ereignisbehandlung fьr die Steuerelemente
  class MeinActionLauscher implements ActionListener {
    public void actionPerformed(ActionEvent e) {
      m_schalter.setText("Спасибо");      
      m_schalter.setIcon(null);      
      }
    }

  public static void main(String[] args) {
    Icon fenster = new Icon("Значок");
    fenster.pack();
    fenster.setSize(300,100);
    fenster.setVisible(true);
  }
}
