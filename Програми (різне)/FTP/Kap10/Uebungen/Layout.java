import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Layout extends JFrame {

  Layout(String titel) {
    super(titel);
    setLayout(new BorderLayout());
    
    Panel p = new Panel();
    JButton schalter1 = new JButton("Нажми меня");
    JButton schalter2 = new JButton("Нажми меня");
    schalter2.setFont(new Font(Font.SERIF, Font.BOLD, 14));
    p.add(schalter1);
    p.add(schalter2);
 
    JButton schalter3 = new JButton("Конечно вы должны нажать меня");
    add(p,"North");
    add(new JLabel("Не слушайте этих двух!",SwingConstants.CENTER),"Center");
    add(schalter3,"South");

    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
  }

  public static void main(String[] args) {
    Layout fenster = new Layout("Layout");
    fenster.pack();
    fenster.setVisible(true);   
  }
}
