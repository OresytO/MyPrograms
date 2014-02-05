import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class LookAndFeel extends JFrame implements ActionListener {
  public static void main(String[] args) {
    LookAndFeel auswahl = new LookAndFeel("����������� �������� ���������� � ������� Swing!");

    auswahl.pack();
    auswahl.setSize(640,400); 
    auswahl.setVisible(true); 
  }


  // der Konstruktor 
  LookAndFeel(String titel) {
    super(titel); 

    //*******************************************
    // den Native Look and Feel erzwingen
    try {
       UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName()); 
    }
    catch(Exception ex) {
       System.err.println("������ LookandFeel\n"); 
    }

    setLayout(new GridLayout(3, 4, 3, 3));

    JPanel zelle1 = new JPanel();
    JPanel zelle2 = new JPanel();
    JPanel zelle3 = new JPanel();
    JPanel zelle4 = new JPanel();
    JPanel zelle5 = new JPanel();
    JPanel zelle6 = new JPanel();
    JPanel zelle7 = new JPanel();
    JPanel zelle8 = new JPanel();
    JPanel zelle9 = new JPanel();
    JPanel zelle10 = new JPanel();
    JPanel zelle11 = new JPanel();
    JPanel zelle12 = new JPanel();

    //*******************************************
    // Komponenten aufnehmen
    
    // Bild f�r Label und Schaltfl�che laden
    ImageIcon icon = new ImageIcon("buttonImage.gif");

    // Label
    JLabel text1 =  new JLabel("��������� �����", icon, SwingConstants.LEFT);
    text1.setFont(new Font("Monospaced", Font.PLAIN,12));
    zelle1.add(text1);

    // Liste 
    String[] elemente = {"�������", "�������", "�����", "�������", "������", "�����", 
                         "���������", "�������", "��������"};
    JList<String> liste = new JList<String>(elemente);
    liste.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
    JScrollPane listenScrollPane = new JScrollPane(liste);
    listenScrollPane.setPreferredSize(new Dimension(90,100));
    zelle2.add(listenScrollPane);
   
    // Kombinationsfeld
    JComboBox<String> kombi = new JComboBox<String>(elemente);
    zelle3.add(kombi);

    // Bildlaufleisten
    JScrollBar bildlauf = new JScrollBar(SwingConstants.VERTICAL,4,1,0,10);
    bildlauf.setPreferredSize(new Dimension(20,100));
    zelle4.add(bildlauf);

    // Schaltfl�che
    JButton schalter =  new JButton("����� ����", icon);
    zelle5.add(schalter);

    // Kontrollk�stchen
    JCheckBox opt1 = new JCheckBox ("����",false);
    JCheckBox opt2 = new JCheckBox ("����",false);
    zelle6.add(opt1);
    zelle6.add(opt2);

    // Optionsfelder
    ButtonGroup gruppe = new ButtonGroup();

    JRadioButton opt3 = new JRadioButton ("�������",false);
    JRadioButton opt4 = new JRadioButton ("�������",false);
    gruppe.add(opt3);
    gruppe.add(opt4);

    zelle7.add(opt3);
    zelle7.add(opt4);

    // Textkomponenten
    JTextField text2 = new JTextField(10);
    text2.setText("���� �����");
    zelle9.add(text2);

    JPasswordField text3 = new JPasswordField(10);
    text3.setEchoChar('*');
    text3.setText("Eingabe");
    zelle10.add(text3);

    JTextArea text4 = new JTextArea(" ��� ���� \n", 4,10);
    text4.append(" ��� ������ � ��������� �����\n Textfeld\n");
    zelle11.add(text4);

    add(zelle1);       
    add(zelle2);       
    add(zelle3);       
    add(zelle4);       
    add(zelle5);       
    add(zelle6);       
    add(zelle7);       
    add(zelle8);       
    add(zelle9);       
    add(zelle10);       
    add(zelle11);       
    add(zelle12);       

    //*******************************************
    // Menueleiste erstellen
    JMenuBar menue_leiste = new JMenuBar();
    JMenu menu1 = new JMenu("���������");
    JMenuItem prog_item1 = new JMenuItem("�������");
    prog_item1.addActionListener(this); 
    menu1.add(prog_item1);

    JMenu menu2 = new JMenu("������");
    JMenuItem frage_item = new JMenuItem("������1 (������)");
    JMenuItem confirm_item = new JMenuItem("������2 (�����)");
    frage_item.addActionListener(this); 
    confirm_item.addActionListener(this); 
    menu2.add(frage_item);
    menu2.add(confirm_item);

    JMenu menu3 = new JMenu("������� ���"); 
    ButtonGroup lookandfeel = new ButtonGroup();
    JRadioButtonMenuItem metal_item = 
                    new JRadioButtonMenuItem("Metal LookAndFeel");
    JRadioButtonMenuItem native_item = 
                    new JRadioButtonMenuItem("Native LookAndFeel");
    metal_item.addActionListener(this);
    native_item.addActionListener(this);
    native_item.setSelected(true); 
    lookandfeel.add(metal_item);
    lookandfeel.add(native_item);

    menu3.add(metal_item);
    menu3.add(native_item);

    menue_leiste.add(menu1);
    menue_leiste.add(menu2);
    menue_leiste.add(menu3); 
    setJMenuBar(menue_leiste); 
    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
  }


  //*******************************************
  // Behandlung der Menubefehle
  public void actionPerformed(ActionEvent e) {
    String quelle = e.getActionCommand();
    if(quelle.equals("Programm beenden"))
       System.exit(0); 

    if(quelle.equals("Metal LookAndFeel")) {
       try {
          UIManager.setLookAndFeel(
             UIManager.getCrossPlatformLookAndFeelClassName());
          SwingUtilities.updateComponentTreeUI(this);
          return;
       }
       catch(Exception ex) {
          // nichts weiter tun
          return; 
       }
    }

    if(quelle.equals("Native LookAndFeel")) {
       try {
           UIManager.setLookAndFeel(
              UIManager.getSystemLookAndFeelClassName());
           SwingUtilities.updateComponentTreeUI(this);
           return; 
       }
       catch(Exception ex) {
           // nichts weiter tun
           return;
       }
    }

    if(quelle.equals("Frage-Dialog")) {
       String antwort;
       antwort =JOptionPane.showInputDialog(this, "��� ���������?");
       JOptionPane.showMessageDialog(this, "� ���� " + antwort); 
       return;
    }
        
    if(quelle.equals("Best�tigungs-Dialog")) {
       int antwort;
       antwort = JOptionPane.showConfirmDialog(this,
                 "��� �������� Java? ");

       switch(antwort) {
          case JOptionPane.YES_OPTION : 
                 JOptionPane.showMessageDialog(this,
                           "��� �����: �� ");
                 break;    
          case JOptionPane.NO_OPTION  : 
                 JOptionPane.showMessageDialog(this,
                         "��� �����: ��� ");
                 break;    
          default                     : 
                 JOptionPane.showMessageDialog(this,
                 "�� �� ��������. "); 
         }
       return; 
    }
  }
} 
