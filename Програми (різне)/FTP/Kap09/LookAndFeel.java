import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class LookAndFeel extends JFrame implements ActionListener {
  public static void main(String[] args) {
    LookAndFeel auswahl = new LookAndFeel("Стандартные элементы управления и диалоги Swing!");

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
       System.err.println("Ошибка LookandFeel\n"); 
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
    
    // Bild fьr Label und Schaltflдche laden
    ImageIcon icon = new ImageIcon("buttonImage.gif");

    // Label
    JLabel text1 =  new JLabel("Статичный текст", icon, SwingConstants.LEFT);
    text1.setFont(new Font("Monospaced", Font.PLAIN,12));
    zelle1.add(text1);

    // Liste 
    String[] elemente = {"Красный", "Зеленый", "Синий", "Розовый", "Черный", "Белый", 
                         "Пурпурный", "Золотой", "Небесный"};
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

    // Schaltflдche
    JButton schalter =  new JButton("Нажми меня", icon);
    zelle5.add(schalter);

    // Kontrollkдstchen
    JCheckBox opt1 = new JCheckBox ("Овца",false);
    JCheckBox opt2 = new JCheckBox ("Козёл",false);
    zelle6.add(opt1);
    zelle6.add(opt2);

    // Optionsfelder
    ButtonGroup gruppe = new ButtonGroup();

    JRadioButton opt3 = new JRadioButton ("Красный",false);
    JRadioButton opt4 = new JRadioButton ("Зеленый",false);
    gruppe.add(opt3);
    gruppe.add(opt4);

    zelle7.add(opt3);
    zelle7.add(opt4);

    // Textkomponenten
    JTextField text2 = new JTextField(10);
    text2.setText("Поле ввода");
    zelle9.add(text2);

    JPasswordField text3 = new JPasswordField(10);
    text3.setEchoChar('*');
    text3.setText("Eingabe");
    zelle10.add(text3);

    JTextArea text4 = new JTextArea(" Это поле \n", 4,10);
    text4.append(" для текста в несколько строк\n Textfeld\n");
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
    JMenu menu1 = new JMenu("Программа");
    JMenuItem prog_item1 = new JMenuItem("Закрыть");
    prog_item1.addActionListener(this); 
    menu1.add(prog_item1);

    JMenu menu2 = new JMenu("Диалог");
    JMenuItem frage_item = new JMenuItem("Диалог1 (вопрос)");
    JMenuItem confirm_item = new JMenuItem("Диалог2 (выбор)");
    frage_item.addActionListener(this); 
    confirm_item.addActionListener(this); 
    menu2.add(frage_item);
    menu2.add(confirm_item);

    JMenu menu3 = new JMenu("Внешний вид"); 
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
       antwort =JOptionPane.showInputDialog(this, "Как поживаете?");
       JOptionPane.showMessageDialog(this, "Я живу " + antwort); 
       return;
    }
        
    if(quelle.equals("Bestдtigungs-Dialog")) {
       int antwort;
       antwort = JOptionPane.showConfirmDialog(this,
                 "Вам нравится Java? ");

       switch(antwort) {
          case JOptionPane.YES_OPTION : 
                 JOptionPane.showMessageDialog(this,
                           "Ваш ответ: Да ");
                 break;    
          case JOptionPane.NO_OPTION  : 
                 JOptionPane.showMessageDialog(this,
                         "Ваш ответ: Нет ");
                 break;    
          default                     : 
                 JOptionPane.showMessageDialog(this,
                 "Вы не ответили. "); 
         }
       return; 
    }
  }
} 
