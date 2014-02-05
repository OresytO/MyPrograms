import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

// Fensterklasse definieren
public class ToolTip extends JFrame {
  JButton m_schalter;

  // ����������� 
  ToolTip(String titel) {
    super(titel);

    setLayout(new FlowLayout());

    m_schalter =  new JButton("����� ����");
    m_schalter.setToolTipText("��, � ��� - ����������� ���������!");

    add(m_schalter);
    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE); 

    // ���������
    m_schalter.addActionListener(new MeinActionLauscher());
  }


  // Ereignisbehandlung f�r die Steuerelemente
  class MeinActionLauscher implements ActionListener {
    public void actionPerformed(ActionEvent e){
      m_schalter.setText("�������");      
    }
  }

  public static void main(String[] args) {
    ToolTip fenster = new ToolTip("������ �� ����������� ����������");
    fenster.pack();
    fenster.setSize(300,100);
    fenster.setVisible(true);
  }
}
