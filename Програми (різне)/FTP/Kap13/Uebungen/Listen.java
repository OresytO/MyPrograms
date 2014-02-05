import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.event.*;

// Fensterklasse definieren
public class Listen extends JFrame {
  DefaultListModel<Integer> m_modell;

  // Конструктор 
  Listen(String titel) {
    super(titel);

    setLayout(new GridLayout(1,2,5,0));
   
    m_modell = new DefaultListModel<Integer>();
    for(int i = 0; i < 20; i++)  {
      m_modell.addElement(new Integer(i));
    }
	
    JList<Integer> liste = new JList<Integer>(m_modell);
    liste.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
    JScrollPane listenScrollPane = new JScrollPane();
    listenScrollPane.getViewport().setView(liste);
   
    String[] elemente = {"Красный", "Зеленый", "Синий", "Розовый"};
    JComboBox<String> kombi = new JComboBox<String>(elemente);

    add(listenScrollPane);
    add(kombi);

    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE); 

    // Слушатель
    ListSelectionModel lsm = liste.getSelectionModel();
    lsm.addListSelectionListener(new ListenLauscher());
    
    kombi.addActionListener(new KombiLauscher());
  }


  // Обработка событий
  class MeinWindowLauscher extends WindowAdapter {
    public void windowClosing(WindowEvent e) {
      System.exit(0);
    }
  }

  class ListenLauscher implements ListSelectionListener  {
    public void valueChanged(ListSelectionEvent e)  {
        if (e.getValueIsAdjusting())
           return;

        ListSelectionModel lsm = (ListSelectionModel) e.getSource();
        if (!lsm.isSelectionEmpty())  {
           int index = lsm.getMinSelectionIndex();
           Integer i= m_modell.getElementAt(index);
           String str = String.valueOf(i);
           JOptionPane.showMessageDialog(null,str);
        }
     }
  }

  class KombiLauscher implements ActionListener  {
    public void actionPerformed(ActionEvent e)  {
        JComboBox cb =  (JComboBox) e.getSource();
        String str = (String) cb.getSelectedItem();
        JOptionPane.showMessageDialog(null,str);
    }
  }


  public static void main(String[] args) {
    Listen fenster = new Listen("Списки");
    fenster.pack();
    fenster.setSize(300,100);
    fenster.setResizable(false);
    fenster.setVisible(true);
  }
}
