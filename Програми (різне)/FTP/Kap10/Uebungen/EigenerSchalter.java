import java.awt.*;
import javax.swing.*;
import java.awt.event.*;


class MeinSchalter extends JButton {
  public MeinSchalter(String titel) {
    super(titel);
  }

  public Dimension getMinimumSize() {
    return new Dimension(100,100);
  }
  public Dimension getPreferredSize() {
    return getMinimumSize();
  }
}
  

public class EigenerSchalter extends JFrame {

  EigenerSchalter(String titel) {
    super(titel);
    setLayout(new FlowLayout());
 
    MeinSchalter schalter = new MeinSchalter("����� ����");
    add(schalter);
 
    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
  }


  public static void main(String[] args) {
    // EigenerSchalter fenster = new EigenerSchalter("Schaltfl�chen");
    EigenerSchalter fenster = new EigenerSchalter("����� ����");
    fenster.pack();
    fenster.setVisible(true);   
  }
}
