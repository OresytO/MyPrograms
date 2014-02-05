import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Layout extends JFrame {

  Layout(String titel) {
    super(titel);
    setLayout(new BorderLayout());
    
    Panel p = new Panel();
    JButton schalter1 = new JButton("����� ����");
    JButton schalter2 = new JButton("����� ����");
    schalter2.setFont(new Font(Font.SERIF, Font.BOLD, 14));
    p.add(schalter1);
    p.add(schalter2);
 
    JButton schalter3 = new JButton("������� �� ������ ������ ����");
    add(p,"North");
    add(new JLabel("�� �������� ���� ����!",SwingConstants.CENTER),"Center");
    add(schalter3,"South");

    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
  }

  public static void main(String[] args) {
    Layout fenster = new Layout("Layout");
    fenster.pack();
    fenster.setVisible(true);   
  }
}
