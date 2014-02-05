import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

// Fensterklasse definieren
public class Optionen extends JFrame {
  JCheckBox m_opt1, m_opt2, m_opt3, m_opt4;
  JRadioButton m_opt5, m_opt6, m_opt7, m_opt8;

  // ����������� 
  Optionen(String titel) {
    super(titel);

    setLayout(new GridLayout(2,4,5,10));
   
    // 1. Markierungsk�stchen erzeugen
    m_opt1 = new JCheckBox ("����",false);
    m_opt2 = new JCheckBox ("�����",false);
    m_opt3 = new JCheckBox ("��������",false); 
    m_opt4 = new JCheckBox ("����",false); 

    // 2. Markierungsk�stchen in Panel aufnehmen
    add(m_opt1);
    add(m_opt2);
    add(m_opt3);
    add(m_opt4);

    // 1. ������ ��������������
    ButtonGroup formauswahl = new ButtonGroup();

    // 2. �������������
    m_opt5 = new JRadioButton ("�������",false);
    m_opt6 = new JRadioButton ("�������",false);
    m_opt7 = new JRadioButton ("�����",false); 
    m_opt8 = new JRadioButton ("�������",false); 

    // 3. ��� ������������� ��������
    m_opt5.setActionCommand("�������");
    m_opt6.setActionCommand("�������");
    m_opt7.setActionCommand("�����");
    m_opt8.setActionCommand("�������");

    // 4. ������������� � ������
    formauswahl.add(m_opt5);
    formauswahl.add(m_opt6);
    formauswahl.add(m_opt7);
    formauswahl.add(m_opt8);

    // 5. ��������� � ������
    add(m_opt5);
    add(m_opt6);
    add(m_opt7);
    add(m_opt8);

    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE); 

    // ���������
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

		// Aufgrund eines Bugs in JDK 1.7.0 ist es nicht m�glich,
		// in der itemStateChanged-Behandlung f�r eine JCheckBox-Objekt
		// einen JOptionPange-Dialog aufzurufen. Der Aufruf w�rde dazu f�hren,
		// dass der Zustand des JCheckBox-Objekts wieder zur�ckgesetzt wird.
        if (source == m_opt1) {
            // JOptionPane.showMessageDialog(null,"����");
        } else if (source == m_opt2) {
            // JOptionPane.showMessageDialog(null,"�����");
        } else if (source == m_opt3) {
            // JOptionPane.showMessageDialog(null,"��������");
        } else if (source == m_opt4) {
            // JOptionPane.showMessageDialog(null,"����");
        }
    }
  }

  class RadioLauscher implements ActionListener {
    public void actionPerformed(ActionEvent e) {
         String label;

         label = e.getActionCommand();
         
         if(label.equals("Rot")) {
	         JOptionPane.showMessageDialog(null,"�������");
         } else if(label.equals("Gr�n")) {
	         JOptionPane.showMessageDialog(null,"�������");
         } else if(label.equals("Blau")) {
	         JOptionPane.showMessageDialog(null,"�����");              
         } else if(label.equals("Rosa")) {
	         JOptionPane.showMessageDialog(null,"�������");      
         }   
    }
  }


  public static void main(String[] args) {
    Optionen fenster = new Optionen("������ � �������������");
    fenster.pack();
    fenster.setSize(500,200);
    fenster.setResizable(false);
    fenster.setVisible(true);
  }
}
