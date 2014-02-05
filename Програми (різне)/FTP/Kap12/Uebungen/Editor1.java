// Не очень простой текстовый редактор - расширенная версия
import java.awt.*;
import java.util.*;
import java.awt.event.*;
import java.io.*;
import javax.swing.*;
import javax.swing.text.*;
import java.awt.print.*; 
import java.text.*; 

public class Editor1 extends JFrame  {
  final int ZEILEN  = 100;   // Размеры большой 
  final int SPALTEN = 400;   // текстовой области

  // Глобальные переменные в классе
  private String m_dateiname;  // zu ladende/speichernde Datei
  private String m_aktText;    // aktueller Text in der TextArea
  private JTextArea m_textanzeige;  // Текстовый компонент
  private JComboBox<String> m_fonts,m_styles;  // Auswahl von Font, Stil 
  private JComboBox<String> m_farben;          // und Farbe
  private Hashtable<String,Action> m_befehle;
  private String suchstring;
  private int    index;

  public static void main(String[] args) {
    // Создание и отображение экземпляра класса
    Editor1 e = new Editor1("Текстовый редактор");

    // Позиция на экране
    e.setLocation(100,100);
    e.pack();
    e.setVisible(true);
  }

  // Im Konstruktur die Benutzerberflдche aufbauen
  Editor1(String titel) {
    super(titel);

    // Menьleiste  mit Menьs anlegen
    JMenuBar menueleiste = new JMenuBar();
    setJMenuBar(menueleiste);

    JMenu menu1 = new JMenu("Файл");
    JMenuItem item1_1 = new JMenuItem("Открыть");
    JMenuItem item1_2 = new JMenuItem("Сохранить");
    JMenuItem item1_3 = new JMenuItem("Печать"); 
    JMenuItem item1_4 = new JMenuItem("Закрыть");
    menu1.add(item1_1);
    menu1.add(item1_2);
    menu1.add(item1_3);
    menu1.add(item1_4);
    menueleiste.add(menu1);

    JMenu menu2 = new JMenu("Правка");
    JMenuItem item2_1 = new JMenuItem("Вырезать");
    JMenuItem item2_2 = new JMenuItem("Копировать");
    JMenuItem item2_3 = new JMenuItem("Вставить");
    menu2.add(item2_1);
    menu2.add(item2_2);
    menu2.add(item2_3);
    menueleiste.add(menu2);

    JMenu menu3 = new JMenu("Поиск");
    JMenuItem item3_1 = new JMenuItem("Найти");
    JMenuItem item3_2 = new JMenuItem("Найти далее");
    menu3.add(item3_1);
    menu3.add(item3_2);
    menueleiste.add(menu3);

    // Панель для области текста и поля выбора
    JPanel p_auЯen = new JPanel();
    p_auЯen.setLayout(new BorderLayout());
      
    // Создание текстового компонента указанных размеров
    m_textanzeige = new JTextArea(ZEILEN, SPALTEN);
    m_textanzeige.setEditable(true);

    // Создать прокручиваемый компонент текста
    JScrollPane scroll = new JScrollPane();
    scroll.getViewport().add(m_textanzeige);      

    // Внутренняя панель для размещения списков 
    JPanel p_innen = new JPanel();
    p_innen.setLayout(new GridLayout(1,4));

    // Выбор шрифта
    String[] fontNames;
    fontNames  = GraphicsEnvironment.getLocalGraphicsEnvironment().getAvailableFontFamilyNames();
    m_fonts = new JComboBox<String>();
    for(int i = 0; i < fontNames.length; i++)
       m_fonts.addItem(fontNames[i]); 
    

    // Выбор начертания шрифта
    m_styles = new JComboBox<String>();
    m_styles.addItem("обычный");
    m_styles.addItem("курсив");
    m_styles.addItem("полужирный");
  
    // Выбор цвета шрифта
    m_farben = new JComboBox<String>();
    m_farben.addItem("Черный");          
    m_farben.addItem("Красный");
    m_farben.addItem("Зеленый");
    m_farben.addItem("Синий");
    m_farben.addItem("Золотой");
    m_farben.addItem("Небесный");
    m_farben.addItem("Пурпурный");
      
    p_innen.add(m_fonts);  
    p_innen.add(m_styles);
    p_innen.add(m_farben);
   
    p_auЯen.setPreferredSize(new Dimension(500,400));
    p_auЯen.add("Center",scroll);  
    p_auЯen.add("North",p_innen); 

    // Добавляем панель
    add(p_auЯen);                
    
    // Установка шрифта, цвета и начертания  
    m_fonts.setSelectedItem("SansSerif");
    m_styles.setSelectedItem("normal");                     
    m_farben.setSelectedIndex(0);          
    fontAktualisieren(); 

 
    // Класс MeinItemAdapter используется в качестве приемника событий от списков
    class MeinItemAdapter implements ItemListener {
      public void itemStateChanged(ItemEvent e) {
         fontAktualisieren();
      }   
    } 
      
    class MeinActionLauscher implements ActionListener {
      public void actionPerformed(ActionEvent e) {
         String label;

         label = e.getActionCommand();

         if(label.equals("Открыть"))
           dateiLaden();

         if(label.equals("Сохранить"))
           dateiSpeichern();

         if(label.equals("Печать"))
           dateiDrucken();

         if(label.equals("Закрыть"))
           System.exit(0);              
          
         if(label.equals("Найти"))
           stringSuchen(null, 0);      
           
         if(label.equals("Найти далее"))
           stringSuchen(suchstring, index);      
      }   
    } 

    // Закрытие окна приложения
    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE); 
   
    // Die Instanz der Adapterklasse fьr den ActionListener 
    // brauchen wir mehrmals, daher erzeugen wir nur eine Instanz                            
    // und verwenden sie mehrfach; das spart ein biЯchen Speicher
    MeinActionLauscher  actionlistener = new MeinActionLauscher();
    item1_1.addActionListener(actionlistener);
    item1_2.addActionListener(actionlistener);
    item1_3.addActionListener(actionlistener);
    item1_4.addActionListener(actionlistener);
    item3_1.addActionListener(actionlistener);
    item3_2.addActionListener(actionlistener);
   
    // Genauso bei dem Lauschobjekt fьr die Items
    MeinItemAdapter itemlistener = new MeinItemAdapter();
    m_fonts.addItemListener(itemlistener);
    m_styles.addItemListener(itemlistener);
    m_farben.addItemListener(itemlistener);

    // Команды для буфера обмена,
    // создание Action-таблицы
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

  } // Конец конструктора Editor1

     
  // Определение и установка параметров шрифта
  // собственный метод для текстового редактора
  void fontAktualisieren() {
    int fontstil;
    String farbe, fontname, style; 
    int punktgrцЯe;
   
    // Die zurzeit gesetzten Attribute ermitteln und setzen
    fontname = (String) m_fonts.getSelectedItem();
    style    = (String) m_styles.getSelectedItem();
    farbe    = (String) m_farben.getSelectedItem();
    
    if(farbe.equals("Черный"))
      m_textanzeige.setForeground(Color.black);
    
    if(farbe.equals("Красный"))                   	
       m_textanzeige.setForeground(Color.red);  	 
      
    if(farbe.equals("Зеленый"))
      m_textanzeige.setForeground(Color.green);
  
    if(farbe.equals("Синий"))
      m_textanzeige.setForeground(Color.blue);
    
    if(farbe.equals("Пурпурный"))
      m_textanzeige.setForeground(Color.magenta); 
    
    if(farbe.equals("Небесный"))
      m_textanzeige.setForeground(Color.cyan);
    
    if(farbe.equals("Золотой"))
      m_textanzeige.setForeground(Color.yellow);
    
  
    // Стиль шрифта — это совокупность констант
    // PLAIN (простой), ITALIC (курсив) и BOLD (жирный)
    fontstil = Font.PLAIN;
   
    if(style.equals("курсив"))         
      fontstil += Font.ITALIC;  
   
    if(style.equals("полужирный"))
      fontstil += Font.BOLD;   	
   
    // Установка выбранных атрибутов шрифта
    m_textanzeige.setFont(new Font(fontname,fontstil,14));
      
  } // Конец метода fontAktualisieren
   
   
  // Загрузка текстового файла.
  // Метод  редактора
  void dateiLaden() {
    FileDialog d = new FileDialog(this,"Text laden...",
                                   FileDialog.LOAD);
   
    d.setVisible(true);
    m_dateiname = d.getDirectory();
    m_dateiname += d.getFile();

    // Если пользователь не выбрал файл, будет возвращен null.
    // Тогда никаких дальнейших действий не выполняем.
    if(m_dateiname == null)
      return;

    // Открытие потока ввода и загрузка файла
    StringBuffer lesepuffer= new StringBuffer(ZEILEN * SPALTEN);
    
    try (FileReader eingabe = new FileReader(m_dateiname);) {
           
      // Считывание символов до тех пор, пока не достигнут конец файла (=-1)  
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
     // Ожидаемое прерывание по достижению конца файла.
     // Никаких дальнейших действий
    }
    catch(FileNotFoundException e) {
      System.err.println(" Файл отсутствует или не читается!\n");
      m_dateiname = null;  
    }
    catch(IOException e) {
      // Sonst irgendwas ist schiefgegangen
      System.err.println(" Ошибка при чтении файла " +
                         m_dateiname + "\n");
      m_dateiname = null;
    }
  } // Конец метода dateiLaden 


  // Сохранение текста.
  // Метод редактора
  void dateiSpeichern() {
    // локальные переменные
    int zeichen,i;

    FileDialog d = new FileDialog(this,"Сохранить...",
                                  FileDialog.SAVE);
   
    d.setVisible(true);
    m_dateiname = d.getDirectory();
    m_dateiname += d.getFile();

    if(m_dateiname == null)
      return;

      // Текст теперь хранится в файле
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
      System.err.println(" Ошибка при сохранении файла  " 
                         + m_dateiname + "\n");
      m_dateiname = null;
    }
  } // Конец 'dateiSpeichern' 


  // Печать текста.
  // Метод  редактора
  void dateiDrucken() {
    if (m_dateiname == null)
      m_dateiname = "Без имени";
      
    try {
       m_textanzeige.print(new MessageFormat(m_dateiname),
                  new MessageFormat("Страница {0}"),
                  true,               // Показать диалог печати
                  null, null, false);
    } catch (PrinterException e) {
       System.err.println(" Печать невозможна.\n");
    }
  }

  // Этот метод ищет строки в тексте.
  // Метод редактора
  void stringSuchen(String suchstring, int index) {
    FrageDialog frage;

    // Диалоговое окно для задания искомой строки
    if (suchstring == null) {
       frage = new FrageDialog(this,"Найти");
       frage.setLocation(150,150);
       frage.pack();
       frage.setVisible(true); 
       suchstring = frage.getString();
       index = 0;
    
       if(suchstring == null)
          return;
    } else {
       // Продолжение поиска
       index += suchstring.length();
    }
        
    // Поиск
    m_aktText = m_textanzeige.getText();
    index = m_aktText.indexOf(suchstring, index);

    if(index == -1) {
       JOptionPane.showMessageDialog(null,"Текст не найден",
                       "Сообщение",JOptionPane.INFORMATION_MESSAGE);
       index = 0;
       suchstring = null;
    } else
       // Выделение найденной строки
       m_textanzeige.select(index, index + suchstring.length() );
       
    // Suchstring und Position in Instanzvariablen speichern
    this.suchstring = suchstring;
    this.index = index;
  
  } // Ende von 'stringSuchen' 

} // Ende von Klasse 'Editor' 


// Класс диалога для ввода искомой строки в редакторе
class FrageDialog extends JDialog implements ActionListener {
  private JTextField eingabefeld;
  private JButton oK, abbruch;
  private String suchstring;

  // Конструктор
  FrageDialog(JFrame f, String titel) {
    super(f,titel,true);  // Конструктор родительского класса
    setResizable(false);  // размеры диалогового окна нельзя изменять

    setLayout(new BorderLayout());

    // Размещение двух панелей. Одна содержит
    // текстовые поля, другая — кнопки.
    JPanel panel1 = new JPanel();
    JLabel label = new JLabel("Введите строку для поиска:");
    panel1.add(label);
    eingabefeld = new JTextField(40);
    panel1.add(eingabefeld);
    add("Center",panel1);

    JPanel panel2 = new JPanel();
    oK = new JButton("OK");
    abbruch = new JButton("Отмена");
    panel2.add(oK);
    panel2.add(abbruch);
    add("South",panel2);
        
    pack();   // Расположение элементов интерфейса, 
              // задание предпочтительных размеров

    // Класс выполняет сам обработку событий от мыши, 
    // т. е. определяет себя в качестве приемника события
    oK.addActionListener(this);
    abbruch.addActionListener(this);

    // Закрытие окна = скрытие окна
    setDefaultCloseOperation(WindowConstants.HIDE_ON_CLOSE);
  }

  public void actionPerformed(ActionEvent e)  {
    String label;

    label = e.getActionCommand();

    if(label.equals("Отмена")) {
      suchstring = null;
      setVisible(false);
      return;
    }        

    if(label.equals("OK")) {
      suchstring = eingabefeld.getText(); 
      setVisible(false); 
      return;
    }
  } // Конец класса ActionPerformed 

  // Эта функция возвращает введенную строку для поиска
  public String getString()  {       
    return suchstring;
  }
} // Конец конструктора FrageDialog 


