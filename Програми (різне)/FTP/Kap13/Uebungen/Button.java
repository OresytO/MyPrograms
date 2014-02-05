import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

// Fensterklasse definieren
public class Button extends JFrame {
  JButton schalter;

  // Конструктор 
  Button(String titel) {
    super(titel);

    setLayout(new BorderLayout());
    schalter =  new JButton("Нажми меня");
    add(schalter);

    // Lauscher einrichten
    schalter.addActionListener(new MeinActionLauscher());

    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE); 
  }


  // Ereignisbehandlung fьr die Steuerelemente
  class MeinActionLauscher implements ActionListener {
    public void actionPerformed(ActionEvent e) {
      schalter.setText("Спасибо");      
    }
  }

  public static void main(String[] args) {
    Button fenster = new Button("Переключение");
    fenster.pack();
    fenster.setSize(300,100);
    fenster.setVisible(true);
  }
}
