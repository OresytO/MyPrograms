// �� ����� ������� ��������� �������� - ����������� ������
import java.awt.*;
import java.util.*;
import java.awt.event.*;
import java.io.*;
import javax.swing.*;
import javax.swing.text.*;
import java.awt.print.*; 
import java.text.*; 

public class Editor1 extends JFrame  {
  final int ZEILEN  = 100;   // ������� ������� 
  final int SPALTEN = 400;   // ��������� �������

  // ���������� ���������� � ������
  private String m_dateiname;  // zu ladende/speichernde Datei
  private String m_aktText;    // aktueller Text in der TextArea
  private JTextArea m_textanzeige;  // ��������� ���������
  private JComboBox<String> m_fonts,m_styles;  // Auswahl von Font, Stil 
  private JComboBox<String> m_farben;          // und Farbe
  private Hashtable<String,Action> m_befehle;
  private String suchstring;
  private int    index;

  public static void main(String[] args) {
    // �������� � ����������� ���������� ������
    Editor1 e = new Editor1("��������� ��������");

    // ������� �� ������
    e.setLocation(100,100);
    e.pack();
    e.setVisible(true);
  }

  // Im Konstruktur die Benutzerberfl�che aufbauen
  Editor1(String titel) {
    super(titel);

    // Men�leiste  mit Men�s anlegen
    JMenuBar menueleiste = new JMenuBar();
    setJMenuBar(menueleiste);

    JMenu menu1 = new JMenu("����");
    JMenuItem item1_1 = new JMenuItem("�������");
    JMenuItem item1_2 = new JMenuItem("���������");
    JMenuItem item1_3 = new JMenuItem("������"); 
    JMenuItem item1_4 = new JMenuItem("�������");
    menu1.add(item1_1);
    menu1.add(item1_2);
    menu1.add(item1_3);
    menu1.add(item1_4);
    menueleiste.add(menu1);

    JMenu menu2 = new JMenu("������");
    JMenuItem item2_1 = new JMenuItem("��������");
    JMenuItem item2_2 = new JMenuItem("����������");
    JMenuItem item2_3 = new JMenuItem("��������");
    menu2.add(item2_1);
    menu2.add(item2_2);
    menu2.add(item2_3);
    menueleiste.add(menu2);

    JMenu menu3 = new JMenu("�����");
    JMenuItem item3_1 = new JMenuItem("�����");
    JMenuItem item3_2 = new JMenuItem("����� �����");
    menu3.add(item3_1);
    menu3.add(item3_2);
    menueleiste.add(menu3);

    // ������ ��� ������� ������ � ���� ������
    JPanel p_au�en = new JPanel();
    p_au�en.setLayout(new BorderLayout());
      
    // �������� ���������� ���������� ��������� ��������
    m_textanzeige = new JTextArea(ZEILEN, SPALTEN);
    m_textanzeige.setEditable(true);

    // ������� �������������� ��������� ������
    JScrollPane scroll = new JScrollPane();
    scroll.getViewport().add(m_textanzeige);      

    // ���������� ������ ��� ���������� ������� 
    JPanel p_innen = new JPanel();
    p_innen.setLayout(new GridLayout(1,4));

    // ����� ������
    String[] fontNames;
    fontNames  = GraphicsEnvironment.getLocalGraphicsEnvironment().getAvailableFontFamilyNames();
    m_fonts = new JComboBox<String>();
    for(int i = 0; i < fontNames.length; i++)
       m_fonts.addItem(fontNames[i]); 
    

    // ����� ���������� ������
    m_styles = new JComboBox<String>();
    m_styles.addItem("�������");
    m_styles.addItem("������");
    m_styles.addItem("����������");
  
    // ����� ����� ������
    m_farben = new JComboBox<String>();
    m_farben.addItem("������");          
    m_farben.addItem("�������");
    m_farben.addItem("�������");
    m_farben.addItem("�����");
    m_farben.addItem("�������");
    m_farben.addItem("��������");
    m_farben.addItem("���������");
      
    p_innen.add(m_fonts);  
    p_innen.add(m_styles);
    p_innen.add(m_farben);
   
    p_au�en.setPreferredSize(new Dimension(500,400));
    p_au�en.add("Center",scroll);  
    p_au�en.add("North",p_innen); 

    // ��������� ������
    add(p_au�en);                
    
    // ��������� ������, ����� � ����������  
    m_fonts.setSelectedItem("SansSerif");
    m_styles.setSelectedItem("normal");                     
    m_farben.setSelectedIndex(0);          
    fontAktualisieren(); 

 
    // ����� MeinItemAdapter ������������ � �������� ��������� ������� �� �������
    class MeinItemAdapter implements ItemListener {
      public void itemStateChanged(ItemEvent e) {
         fontAktualisieren();
      }   
    } 
      
    class MeinActionLauscher implements ActionListener {
      public void actionPerformed(ActionEvent e) {
         String label;

         label = e.getActionCommand();

         if(label.equals("�������"))
           dateiLaden();

         if(label.equals("���������"))
           dateiSpeichern();

         if(label.equals("������"))
           dateiDrucken();

         if(label.equals("�������"))
           System.exit(0);              
          
         if(label.equals("�����"))
           stringSuchen(null, 0);      
           
         if(label.equals("����� �����"))
           stringSuchen(suchstring, index);      
      }   
    } 

    // �������� ���� ����������
    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE); 
   
    // Die Instanz der Adapterklasse f�r den ActionListener 
    // brauchen wir mehrmals, daher erzeugen wir nur eine Instanz                            
    // und verwenden sie mehrfach; das spart ein bi�chen Speicher
    MeinActionLauscher  actionlistener = new MeinActionLauscher();
    item1_1.addActionListener(actionlistener);
    item1_2.addActionListener(actionlistener);
    item1_3.addActionListener(actionlistener);
    item1_4.addActionListener(actionlistener);
    item3_1.addActionListener(actionlistener);
    item3_2.addActionListener(actionlistener);
   
    // Genauso bei dem Lauschobjekt f�r die Items
    MeinItemAdapter itemlistener = new MeinItemAdapter();
    m_fonts.addItemListener(itemlistener);
    m_styles.addItemListener(itemlistener);
    m_farben.addItemListener(itemlistener);

    // ������� ��� ������ ������,
    // �������� Action-�������
    m_befehle = new Hashtable<String,Action>();
    Action[] actionsArray = m_textanzeige.getActions();
    for (int i = 0; i < actionsArray.length; i++) {
       Action a = actionsArray[i];
       m_befehle.put((String) a.getValue(Action.NAME), a);
    }

    item2_1.addActionListener(m_befehle.get(
                                  DefaultEditorKit.cutAction));
    item2_2.addActionListener(m_befehle.get(
                                  DefaultEditorKit.copyAction));
    item2_3.addActionListener(m_befehle.get(
                                  DefaultEditorKit.pasteAction));

  } // ����� ������������ Editor1

     
  // ����������� � ��������� ���������� ������
  // ����������� ����� ��� ���������� ���������
  void fontAktualisieren() {
    int fontstil;
    String farbe, fontname, style; 
    int punktgr��e;
   
    // Die zurzeit gesetzten Attribute ermitteln und setzen
    fontname = (String) m_fonts.getSelectedItem();
    style    = (String) m_styles.getSelectedItem();
    farbe    = (String) m_farben.getSelectedItem();
    
    if(farbe.equals("������"))
      m_textanzeige.setForeground(Color.black);
    
    if(farbe.equals("�������"))                   	
       m_textanzeige.setForeground(Color.red);  	 
      
    if(farbe.equals("�������"))
      m_textanzeige.setForeground(Color.green);
  
    if(farbe.equals("�����"))
      m_textanzeige.setForeground(Color.blue);
    
    if(farbe.equals("���������"))
      m_textanzeige.setForeground(Color.magenta); 
    
    if(farbe.equals("��������"))
      m_textanzeige.setForeground(Color.cyan);
    
    if(farbe.equals("�������"))
      m_textanzeige.setForeground(Color.yellow);
    
  
    // ����� ������ � ��� ������������ ��������
    // PLAIN (�������), ITALIC (������) � BOLD (������)
    fontstil = Font.PLAIN;
   
    if(style.equals("������"))         
      fontstil += Font.ITALIC;  
   
    if(style.equals("����������"))
      fontstil += Font.BOLD;   	
   
    // ��������� ��������� ��������� ������
    m_textanzeige.setFont(new Font(fontname,fontstil,14));
      
  } // ����� ������ fontAktualisieren
   
   
  // �������� ���������� �����.
  // �����  ���������
  void dateiLaden() {
    FileDialog d = new FileDialog(this,"Text laden...",
                                   FileDialog.LOAD);
   
    d.setVisible(true);
    m_dateiname = d.getDirectory();
    m_dateiname += d.getFile();

    // ���� ������������ �� ������ ����, ����� ��������� null.
    // ����� ������� ���������� �������� �� ���������.
    if(m_dateiname == null)
      return;

    // �������� ������ ����� � �������� �����
    StringBuffer lesepuffer= new StringBuffer(ZEILEN * SPALTEN);
    
    try (FileReader eingabe = new FileReader(m_dateiname);) {
           
      // ���������� �������� �� ��� ���, ���� �� ��������� ����� ����� (=-1)  
      char zeichen;
      int gelesen;
      int zeilen = 0;
      boolean weiter = true;
  
      while(weiter) {
         gelesen = eingabe.read();

         if(gelesen == -1) {
           weiter = false;
           continue;
         }

         zeichen = (char) gelesen;
         lesepuffer.append(zeichen);
      }

      m_aktText = new String(lesepuffer);
      m_textanzeige.setText(m_aktText);	
      m_textanzeige.setCaretPosition(0);
    }
    catch(EOFException e) {
     // ��������� ���������� �� ���������� ����� �����.
     // ������� ���������� ��������
    }
    catch(FileNotFoundException e) {
      System.err.println(" ���� ����������� ��� �� ��������!\n");
      m_dateiname = null;  
    }
    catch(IOException e) {
      // Sonst irgendwas ist schiefgegangen
      System.err.println(" ������ ��� ������ ����� " +
                         m_dateiname + "\n");
      m_dateiname = null;
    }
  } // ����� ������ dateiLaden 


  // ���������� ������.
  // ����� ���������
  void dateiSpeichern() {
    // ��������� ����������
    int zeichen,i;

    FileDialog d = new FileDialog(this,"���������...",
                                  FileDialog.SAVE);
   
    d.setVisible(true);
    m_dateiname = d.getDirectory();
    m_dateiname += d.getFile();

    if(m_dateiname == null)
      return;

      // ����� ������ �������� � �����
    try (FileWriter ausgabe = new FileWriter(m_dateiname);) {

      // den aktuellen Text ermitteln und speichern
      m_aktText = m_textanzeige.getText();
 
      for(i = 0; i < m_aktText.length(); i++) {
        zeichen = (int) m_aktText.charAt(i);
        ausgabe.write(zeichen);
      }
    }
    catch(IOException e) {
      //  irgendwas ist schiefgegangen
      System.err.println(" ������ ��� ���������� �����  " 
                         + m_dateiname + "\n");
      m_dateiname = null;
    }
  } // ����� 'dateiSpeichern' 


  // ������ ������.
  // �����  ���������
  void dateiDrucken() {
    if (m_dateiname == null)
      m_dateiname = "��� �����";
      
    try {
       m_textanzeige.print(new MessageFormat(m_dateiname),
                  new MessageFormat("�������� {0}"),
                  true,               // �������� ������ ������
                  null, null, false);
    } catch (PrinterException e) {
       System.err.println(" ������ ����������.\n");
    }
  }

  // ���� ����� ���� ������ � ������.
  // ����� ���������
  void stringSuchen(String suchstring, int index) {
    FrageDialog frage;

    // ���������� ���� ��� ������� ������� ������
    if (suchstring == null) {
       frage = new FrageDialog(this,"�����");
       frage.setLocation(150,150);
       frage.pack();
       frage.setVisible(true); 
       suchstring = frage.getString();
       index = 0;
    
       if(suchstring == null)
          return;
    } else {
       // ����������� ������
       index += suchstring.length();
    }
        
    // �����
    m_aktText = m_textanzeige.getText();
    index = m_aktText.indexOf(suchstring, index);

    if(index == -1) {
       JOptionPane.showMessageDialog(null,"����� �� ������",
                       "���������",JOptionPane.INFORMATION_MESSAGE);
       index = 0;
       suchstring = null;
    } else
       // ��������� ��������� ������
       m_textanzeige.select(index, index + suchstring.length() );
       
    // Suchstring und Position in Instanzvariablen speichern
    this.suchstring = suchstring;
    this.index = index;
  
  } // Ende von 'stringSuchen' 

} // Ende von Klasse 'Editor' 


// ����� ������� ��� ����� ������� ������ � ���������
class FrageDialog extends JDialog implements ActionListener {
  private JTextField eingabefeld;
  private JButton oK, abbruch;
  private String suchstring;

  // �����������
  FrageDialog(JFrame f, String titel) {
    super(f,titel,true);  // ����������� ������������� ������
    setResizable(false);  // ������� ����������� ���� ������ ��������

    setLayout(new BorderLayout());

    // ���������� ���� �������. ���� ��������
    // ��������� ����, ������ � ������.
    JPanel panel1 = new JPanel();
    JLabel label = new JLabel("������� ������ ��� ������:");
    panel1.add(label);
    eingabefeld = new JTextField(40);
    panel1.add(eingabefeld);
    add("Center",panel1);

    JPanel panel2 = new JPanel();
    oK = new JButton("OK");
    abbruch = new JButton("������");
    panel2.add(oK);
    panel2.add(abbruch);
    add("South",panel2);
        
    pack();   // ������������ ��������� ����������, 
              // ������� ���������������� ��������

    // ����� ��������� ��� ��������� ������� �� ����, 
    // �. �. ���������� ���� � �������� ��������� �������
    oK.addActionListener(this);
    abbruch.addActionListener(this);

    // �������� ���� = ������� ����
    setDefaultCloseOperation(WindowConstants.HIDE_ON_CLOSE);
  }

  public void actionPerformed(ActionEvent e)  {
    String label;

    label = e.getActionCommand();

    if(label.equals("������")) {
      suchstring = null;
      setVisible(false);
      return;
    }        

    if(label.equals("OK")) {
      suchstring = eingabefeld.getText(); 
      setVisible(false); 
      return;
    }
  } // ����� ������ ActionPerformed 

  // ��� ������� ���������� ��������� ������ ��� ������
  public String getString()  {       
    return suchstring;
  }
} // ����� ������������ FrageDialog 


