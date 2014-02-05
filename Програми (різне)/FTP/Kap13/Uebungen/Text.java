import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

// Fensterklasse definieren
public class Text extends JFrame {

  // Конструктор 
  Text(String titel) {
    super(titel);

    setLayout(new BorderLayout());
   
    JPanel panel = new JPanel();
    panel.setLayout(new FlowLayout());

    JLabel l_name = new JLabel("Имя:  ", SwingConstants.RIGHT);
    JTextField name= new JTextField(20);
    panel.add(l_name);
    panel.add(name);

    JLabel l_passwort = new JLabel("Пароль:  ", SwingConstants.RIGHT);
    JPasswordField passwort= new JPasswordField(10);
    passwort.setEchoChar('*');
    panel.add(l_passwort);
    panel.add(passwort);
    add("North",panel);

    JTextArea hilfstext = new JTextArea(" Введите, пожалуйста, \n", 3,30);
    hilfstext.append(" имя и пароль.\n");
    hilfstext.setEditable(false);
    hilfstext.setFont(new Font ("Monospaced",Font.BOLD,12));
    hilfstext.setBackground(Color.lightGray);
    add("Center",hilfstext);

    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE); 
  }


  public static void main(String[] args) {
    Text fenster = new Text("Текстовые поля");
    fenster.pack();
    fenster.setSize(500,200);
    fenster.setResizable(false);
    fenster.setVisible(true);
  }
}
