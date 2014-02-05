// Файл T_Applet.java 

// Апплет для микрокалькулятора
import java.awt.*;
import java.awt.event.*;
import java.applet.*;

class Taschenrechner extends Panel implements ActionListener {
  double m_speicher = 0;        // Память данных 
  double m_zwischenWert = 0;    // для 1-го операнда
  boolean m_operand = false;    // 1. Операнд введен?
  char m_aktOperation = 'k';    // 'k'операция
  boolean m_neueZahl = true ;   // Новое число?
  boolean m_vorKomma = true;    // кнопка '.' нажата?
  TextField m_anzeige;          // Окно для отображения вычислений и результатов

  // Конструктор
  Taschenrechner() {
    // Layout-менеджер для класса 
    // строк и столбец с 5-пиксельными интервалами между ними
    setLayout(new GridLayout(6,1,5,5));

    m_anzeige = new TextField(20);
    m_anzeige.setEditable(false); 
    m_anzeige.setText("0.0"); 
    m_anzeige.setBackground(Color.yellow);

    // Формирование кнопок
    Button taste_0 = new Button("0");
    Button taste_1 = new Button("1");
    Button taste_2 = new Button("2");
    Button taste_3 = new Button("3");
    Button taste_4 = new Button("4");
    Button taste_5 = new Button("5");
    Button taste_6 = new Button("6");
    Button taste_7 = new Button("7");
    Button taste_8 = new Button("8");
    Button taste_9 = new Button("9");

    Button plus = new Button("+");
    Button minus = new Button("-");
    Button mal = new Button("*");
    Button geteilt = new Button("/");
    Button gleich = new Button("=");
    Button punkt = new Button(".");
    Button plusminus = new Button("+/-");
    Button speichern = new Button("M+");
    Button laden = new Button("RL");
    Button lцschen = new Button("C");

    // Построчное расположение в панели
    Panel zeile1 = new Panel();
    Panel zeile2 = new Panel();
    Panel zeile3 = new Panel();
    Panel zeile4 = new Panel();

    GridLayout zeilenLayout = new GridLayout(1,5,5,5);
    zeile1.setLayout(zeilenLayout);
    zeile2.setLayout(zeilenLayout);
    zeile3.setLayout(zeilenLayout);
    zeile4.setLayout(zeilenLayout);

    // Добавление компонентов
    add(m_anzeige);       // Текстовое поле
    add(new Label(""));   // Пустая строка для разряжения

    zeile1.add(taste_7);
    zeile1.add(taste_8);
    zeile1.add(taste_9);
    zeile1.add(geteilt);
    zeile1.add(lцschen);
    add(zeile1);

    zeile2.add(taste_4);
    zeile2.add(taste_5);
    zeile2.add(taste_6);
    zeile2.add(mal);
    zeile2.add(speichern);
    add(zeile2);

    zeile3.add(taste_1);
    zeile3.add(taste_2);
    zeile3.add(taste_3);
    zeile3.add(plus);
    zeile3.add(laden);
    add(zeile3);

    zeile4.add(taste_0);
    zeile4.add(plusminus);
    zeile4.add(punkt);
    zeile4.add(minus);
    zeile4.add(gleich);
    add(zeile4);
    
    // Добавление прослушивателей событий для кнопок 
    taste_0.addActionListener(this);
    taste_1.addActionListener(this);
    taste_2.addActionListener(this);
    taste_3.addActionListener(this);
    taste_4.addActionListener(this);
    taste_5.addActionListener(this);
    taste_6.addActionListener(this);
    taste_7.addActionListener(this);
    taste_8.addActionListener(this);
    taste_9.addActionListener(this);
    taste_0.addActionListener(this);

    plus.addActionListener(this);
    minus.addActionListener(this);
    mal.addActionListener(this);
    gleich.addActionListener(this);
    geteilt.addActionListener(this);
    lцschen.addActionListener(this);
    speichern.addActionListener(this);
    laden.addActionListener(this);
    plusminus.addActionListener(this);
    punkt.addActionListener(this);
  }

  // Обработка событий от кнопок
  public void actionPerformed(ActionEvent e) {
    String str, aktText;
    int index;
    char zeichen;
    double wert;

    str = e.getActionCommand();
    // Определение, какая кнопка была нажата 
    if(str.equals("+/-")) {
      // Замена признака
      wert= Double.valueOf(m_anzeige.getText()).doubleValue();
      wert *= -1;
      m_anzeige.setText(Double.toString(wert));
      return;
    }

    if(str.equals("M+")) {
      // Запись текущего значения в память
      m_speicher = Double.valueOf(m_anzeige.getText()).doubleValue();
      return;
    }

    if(str.equals("RL")) {
      // Просмотр содержимого переменных памяти 
      m_anzeige.setText(Double.toString(m_speicher));
      return;
    }

    // Для остальных кнопок можно определить действие
    // по первому символу в надписи на кнопке.
    // Поэтому можем работать с удобной командой switch.
    zeichen = str.charAt(0);

    switch(zeichen) {
      case 'C' : // сброс
                 m_anzeige.setText("0.0");
                 m_speicher = 0;
                 m_zwischenWert = 0;
                 m_aktOperation = 'k';
                 m_operand = false;
                 m_vorKomma = true;
                 m_neueZahl = true;
                 break;
      case '+':
      case '-':
      case '*':
      case '/': // Символ текущей операции и 
                // сохранение 1-го операнда в буфере
                if(m_aktOperation == 'k') {
                   // прежде 'k' операция
                   m_zwischenWert = Double.valueOf(
                                      m_anzeige.getText()).doubleValue();
                   m_operand = true;
                   m_aktOperation = zeichen;
                   m_neueZahl = true;
                   break;
                }
                if(m_operand == true) {
                   berechnungAusfьhren();
                   m_neueZahl = true;
                   m_vorKomma = true;
                   m_aktOperation = zeichen;
                   break;
                }
      case '=': // Запуск сохраненной операции 
               if(m_aktOperation!='k'&& m_operand==true) {
                  berechnungAusfьhren();
                  m_aktOperation = 'k';
                  m_operand = false;
                  m_neueZahl = true;
                  m_vorKomma = true;
                  break;
                }
      case '.': // Введен символ точки 
                if(m_neueZahl == true) {
                  // если число начинается с запятой,
                  // то значение перед запятой равно 0
                  m_anzeige.setText("0");
                  m_neueZahl = false;
                }
                if(m_vorKomma == true) {
                  m_vorKomma = false;
                  aktText = m_anzeige.getText();
                  aktText += ".";
                  m_anzeige.setText(aktText);
                }
                break;
      default: // остаются только кнопки с цифрами 
               if(m_neueZahl == true) {
                  m_neueZahl = false;
                  m_anzeige.setText("");
               }
               aktText = m_anzeige.getText();
               m_anzeige.setText(aktText + zeichen);
               break;
      }
  }

  // Здесь рассчитывается и отображается результат
  void berechnungAusfьhren() {
    double operand1,operand2;
    double ergebnis = 0;

    operand1 = m_zwischenWert;
    operand2 = Double.valueOf(m_anzeige.getText()).doubleValue();
             
    switch(m_aktOperation) {
       case '+': ergebnis = operand1 + operand2;
                 break;
       case '-': ergebnis = operand1 - operand2;
                 break;
       case '*': ergebnis = operand1 * operand2;
                 break;
       case '/': if(operand2 != 0)
                   ergebnis = operand1 / operand2;
                 else
                   ergebnis = 0;
                 break;
    }

    // Результат сохраняется как новое промежуточное значение
    m_zwischenWert = ergebnis;
    m_anzeige.setText(Double.toString(ergebnis));
  }

  // Установка желательных размеров калькулятора
  public Dimension getMinimumSize() {
    return getPreferredSize();
  }

  public Dimension getPreferredSize() {
    return new Dimension(250,250);
  }
}   // Конец класса TaschenRechner




public class T_Applet extends Applet {
  public void init() {
    // Размещение экземпляра Taschenrechners
    Taschenrechner t = new Taschenrechner();
    add(t); 
  }
}

