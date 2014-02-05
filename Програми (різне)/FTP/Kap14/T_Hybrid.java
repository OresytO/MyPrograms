// Datei T_Hybrid.java  

// Ein einfacher Taschenrechner
import java.awt.*;
import java.awt.event.*;
import java.applet.*;

class Taschenrechner extends Panel implements ActionListener {
  double m_speicher = 0;        // Datenspeicher 
  double m_zwischenWert = 0;    // für 1. Operand
  boolean m_operand = false;    // 1. Operand eingegeben?
  char m_aktOperation = 'k';    // 'k'eine Operation
  boolean m_neueZahl = true ;   // neue Zahl ?
  boolean m_vorKomma = true;    // '.' gedrückt ?
  TextField m_anzeige;          // Display

  // Konstruktor 
  Taschenrechner() {
    // der Layout-Manager für die Klasse 
    // sechs Zeilen und eine Spalte mit 5 Pixel Abstand dazwischen
    setLayout(new GridLayout(6,1,5,5));

    m_anzeige = new TextField(20);
    m_anzeige.setEditable(false); 
    m_anzeige.setText("0.0"); 
    m_anzeige.setBackground(Color.yellow);

    // Schaltflächen erzeugen
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
    Button speichern = new Button("STO");
    Button laden = new Button("RL");
    Button löschen = new Button("C");

    // In Panels zeilenweise anordnen
    Panel zeile1 = new Panel();
    Panel zeile2 = new Panel();
    Panel zeile3 = new Panel();
    Panel zeile4 = new Panel();

    GridLayout zeilenLayout = new GridLayout(1,5,5,5);
    zeile1.setLayout(zeilenLayout);
    zeile2.setLayout(zeilenLayout);
    zeile3.setLayout(zeilenLayout);
    zeile4.setLayout(zeilenLayout);

    // Nun die Komponenten hinzufügen
    add(m_anzeige);       // das TextField
    add(new Label(""));   // leere Zeile zur Auflockerung

    zeile1.add(taste_7);
    zeile1.add(taste_8);
    zeile1.add(taste_9);
    zeile1.add(geteilt);
    zeile1.add(löschen);
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
    
    // die Schaltflächen bei einem Lauscher registrieren. 
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
    löschen.addActionListener(this);
    speichern.addActionListener(this);
    laden.addActionListener(this);
    plusminus.addActionListener(this);
    punkt.addActionListener(this);
  }

  // Ereignisbehandlung
  public void actionPerformed(ActionEvent e) {
    String str, aktText;
    int index;
    char zeichen;
    double wert;

    str = e.getActionCommand();
    // Ermitteln, welche Schaltfläche gedrückt wurde 
    if(str.equals("+/-")) {
      // Vorzeichen wechseln
      wert= Double.valueOf(
                 m_anzeige.getText()).doubleValue();
      wert *= -1;
      m_anzeige.setText(Double.toString(wert));
      return;
    }

    if(str.equals("STO")) {
      // den aktuellen Wert im Display abspeichern
      m_speicher = Double.valueOf(
                 m_anzeige.getText()).doubleValue();
      return;
    }

    if(str.equals("RL")) {
      // den Inhalt der Speichervariablen anzeigen 
      m_anzeige.setText(Double.toString(m_speicher));
      return;
    }

    // die restlichen Schaltflächen haben nur ein Zeichen 
    // als Beschriftung. Daher betrachten wir nur 
    // das erste Zeichen und können mit der 
    // handlichen switch-Anweisung arbeiten
    zeichen = str.charAt(0);

    switch(zeichen) {
      case 'C' : // alles zurücksetzen
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
      case '/': // die aktuelle Operation merken und 
                // den 1. Operand zwischenspeichern
                if(m_aktOperation == 'k') {
                   // 'k'eine Operation vorher
                   m_zwischenWert = Double.valueOf(
                                      m_anzeige.getText()).doubleValue();
                   m_operand = true;
                   m_aktOperation = zeichen;
                   m_neueZahl = true;
                   break;
                }
                if(m_operand == true) {
                   berechnungAusführen();
                   m_neueZahl = true;
                   m_vorKomma = true;
                   m_aktOperation = zeichen;
                   break;
                }
      case '=': // eine schwebende Operation 
                // ausführen
               if(m_aktOperation!='k' 
                           && m_operand==true) {
                  berechnungAusführen();
                  m_aktOperation = 'k';
                  m_operand = false;
                  m_neueZahl = true;
                  m_vorKomma = true;
                  break;
                }
      case '.': // Wenn noch kein Punkt eingeben 
                // worden ist, einen hinzufügen 
                if(m_neueZahl == true) {
                  // wenn mit einem Komma begonnen 
                  // wird, ist der Vorkomma-Wert 0
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
      default: // alles andere muß ein Zahlen-Schaltfläche 
               // sein
               if(m_neueZahl == true) {
                  m_neueZahl = false;
                  m_anzeige.setText("");
               }
               aktText = m_anzeige.getText();
               m_anzeige.setText(aktText + zeichen);
               break;
      }
  }

  // Hier wird das Ergebnis berechnet und angezeigt
  void berechnungAusführen() {
    double operand1,operand2;
    double ergebnis = 0;

    operand1 = m_zwischenWert;
    operand2 = Double.valueOf(
             m_anzeige.getText()).doubleValue();
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

    // Das Ergebnis wird als neuer Zwischenwert gespeichert
    m_zwischenWert = ergebnis;
    m_anzeige.setText(Double.toString(ergebnis));
  }

  // Lieblingsgröße des Taschenrechners festlegen
  public Dimension getMinimumSize() {
    return getPreferredSize();
  }

  public Dimension getPreferredSize() {
    return new Dimension(250,250);
  }
}   // Ende der Klasse 'TaschenRechner'


public class T_Hybrid extends Applet {
  public static void main(String[] args) {
    // das umgebende Fenster anlegen
    Frame fenster = new Frame("Àïïëåò êàê ïðèëîæåíèå");

    // für das Fenster muß noch das Beenden des 
    // Programms ermöglicht werden
    class FensterAdapter extends WindowAdapter {
       public void windowClosing(WindowEvent e) {
         System.exit(0);
       }
    }

    // bei einer Instanz des Lauschers anmelden
    fenster.addWindowListener(new FensterAdapter()); 
                                          
    // eine Instanz des Applets anlegen und
    // zum Fenster hinzufügen
    T_Hybrid calc = new T_Hybrid();
    calc.init();
    fenster.add(calc);
    fenster.pack();
    fenster.setVisible(true);
  }

  public void init() {
    // eine Instanz des Taschenrechners anlegen
    Taschenrechner t = new Taschenrechner();
    add(t); 
  }
}

