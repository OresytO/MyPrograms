import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

// Fensterklasse definieren
public class ToolTip extends JFrame {
  JButton m_schalter;

  // Конструктор 
  ToolTip(String titel) {
    super(titel);

    setLayout(new FlowLayout());

    m_schalter =  new JButton("Нажми меня");
    m_schalter.setToolTipText("Ну, а это - всплывающая подсказка!");

    add(m_schalter);
    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE); 

    // Слушатель
    m_schalter.addActionListener(new MeinActionLauscher());
  }


  // Ereignisbehandlung fьr die Steuerelemente
  class MeinActionLauscher implements ActionListener {
    public void actionPerformed(ActionEvent e){
      m_schalter.setText("Спасибо");      
    }
  }

  public static void main(String[] args) {
    ToolTip fenster = new ToolTip("Кнопка со всплывающей подсказкой");
    fenster.pack();
    fenster.setSize(300,100);
    fenster.setVisible(true);
  }
}
