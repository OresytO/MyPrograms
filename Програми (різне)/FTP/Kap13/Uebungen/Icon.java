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
    m_schalter =  new JButton("����� ����", icon);
    add(m_schalter);

    // Lauscher einrichten
    m_schalter.addActionListener(new MeinActionLauscher());

    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE); 
  }


  // Ereignisbehandlung f�r die Steuerelemente
  class MeinActionLauscher implements ActionListener {
    public void actionPerformed(ActionEvent e) {
      m_schalter.setText("�������");      
      m_schalter.setIcon(null);      
      }
    }

  public static void main(String[] args) {
    Icon fenster = new Icon("������");
    fenster.pack();
    fenster.setSize(300,100);
    fenster.setVisible(true);
  }
}
