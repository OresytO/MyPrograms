import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

// ����������� ������ ����
public class Label extends JFrame {

  // ����������� 
  Label(String titel) {
    super(titel);

    setLayout(new BorderLayout());

    JLabel text1 =  new JLabel("��� ��� ���?", SwingConstants.LEFT );
    text1.setFont(new Font("Monospaced", Font.PLAIN,10));

    JLabel text2 = new JLabel("�� ���� �������?", SwingConstants.LEFT );
    text2.setFont(new Font("Monospaced",Font.PLAIN,15));

    JLabel text3 = new JLabel("���� ����� ���-������?..", SwingConstants.LEFT );
    text3.setFont(new Font("Monospaced",Font.BOLD,20));

    add(text1,"North");
    add(text2,"Center");
    add(text3,"South");

    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE); 
  }


  public static void main(String[] args) {
    Label fenster = new Label("��������� ��������� ����");
    fenster.pack();
    fenster.setSize(300,100);
    fenster.setVisible(true);
  }
}
