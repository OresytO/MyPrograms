import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

// Fensterklasse definieren
public class Button extends JFrame {
  JButton schalter;

  // ����������� 
  Button(String titel) {
    super(titel);

    setLayout(new BorderLayout());
    schalter =  new JButton("����� ����");
    add(schalter);

    // Lauscher einrichten
    schalter.addActionListener(new MeinActionLauscher());

    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE); 
  }


  // Ereignisbehandlung f�r die Steuerelemente
  class MeinActionLauscher implements ActionListener {
    public void actionPerformed(ActionEvent e) {
      schalter.setText("�������");      
    }
  }

  public static void main(String[] args) {
    Button fenster = new Button("������������");
    fenster.pack();
    fenster.setSize(300,100);
    fenster.setVisible(true);
  }
}
