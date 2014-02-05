import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

// Fensterklasse definieren
public class Optionen extends JFrame {
  JCheckBox m_opt1, m_opt2, m_opt3, m_opt4;
  JRadioButton m_opt5, m_opt6, m_opt7, m_opt8;

  // Конструктор 
  Optionen(String titel) {
    super(titel);

    setLayout(new GridLayout(2,4,5,10));
   
    // 1. Markierungskдstchen erzeugen
    m_opt1 = new JCheckBox ("Овца",false);
    m_opt2 = new JCheckBox ("Козел",false);
    m_opt3 = new JCheckBox ("Кузнечик",false); 
    m_opt4 = new JCheckBox ("Гриф",false); 

    // 2. Markierungskдstchen in Panel aufnehmen
    add(m_opt1);
    add(m_opt2);
    add(m_opt3);
    add(m_opt4);

    // 1. Группа переключателей
    ButtonGroup formauswahl = new ButtonGroup();

    // 2. Переключатели
    m_opt5 = new JRadioButton ("Красный",false);
    m_opt6 = new JRadioButton ("Зеленый",false);
    m_opt7 = new JRadioButton ("Синий",false); 
    m_opt8 = new JRadioButton ("Розовый",false); 

    // 3. Все переключатели сброшены
    m_opt5.setActionCommand("Красный");
    m_opt6.setActionCommand("Зеленый");
    m_opt7.setActionCommand("Синий");
    m_opt8.setActionCommand("Розовый");

    // 4. Переключатели в группе
    formauswahl.add(m_opt5);
    formauswahl.add(m_opt6);
    formauswahl.add(m_opt7);
    formauswahl.add(m_opt8);

    // 5. Добавляем в панель
    add(m_opt5);
    add(m_opt6);
    add(m_opt7);
    add(m_opt8);

    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE); 

    // Слушатель
    CheckBoxLauscher meinLauscherOpt1 = new CheckBoxLauscher();
    m_opt1.addItemListener(meinLauscherOpt1);
    m_opt2.addItemListener(meinLauscherOpt1);
    m_opt3.addItemListener(meinLauscherOpt1);
    m_opt4.addItemListener(meinLauscherOpt1);

    RadioLauscher meinLauscherOpt2 = new RadioLauscher();
    m_opt5.addActionListener(meinLauscherOpt2);
    m_opt6.addActionListener(meinLauscherOpt2);
    m_opt7.addActionListener(meinLauscherOpt2);
    m_opt8.addActionListener(meinLauscherOpt2);
  }


  class CheckBoxLauscher implements ItemListener  {
    public void itemStateChanged(ItemEvent e) {
        JCheckBox source = (JCheckBox) e.getSource();   

		// Aufgrund eines Bugs in JDK 1.7.0 ist es nicht mцglich,
		// in der itemStateChanged-Behandlung fьr eine JCheckBox-Objekt
		// einen JOptionPange-Dialog aufzurufen. Der Aufruf wьrde dazu fьhren,
		// dass der Zustand des JCheckBox-Objekts wieder zurьckgesetzt wird.
        if (source == m_opt1) {
            // JOptionPane.showMessageDialog(null,"Овца");
        } else if (source == m_opt2) {
            // JOptionPane.showMessageDialog(null,"Козел");
        } else if (source == m_opt3) {
            // JOptionPane.showMessageDialog(null,"Кузнечик");
        } else if (source == m_opt4) {
            // JOptionPane.showMessageDialog(null,"Гриф");
        }
    }
  }

  class RadioLauscher implements ActionListener {
    public void actionPerformed(ActionEvent e) {
         String label;

         label = e.getActionCommand();
         
         if(label.equals("Rot")) {
	         JOptionPane.showMessageDialog(null,"Красный");
         } else if(label.equals("Grьn")) {
	         JOptionPane.showMessageDialog(null,"Зеленый");
         } else if(label.equals("Blau")) {
	         JOptionPane.showMessageDialog(null,"Синий");              
         } else if(label.equals("Rosa")) {
	         JOptionPane.showMessageDialog(null,"Розовый");      
         }   
    }
  }


  public static void main(String[] args) {
    Optionen fenster = new Optionen("Флажки и переключатели");
    fenster.pack();
    fenster.setSize(500,200);
    fenster.setResizable(false);
    fenster.setVisible(true);
  }
}
