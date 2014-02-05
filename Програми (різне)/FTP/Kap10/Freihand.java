// Freihandlinien
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Freihand extends JFrame {
  MeineCanvas m_malflache;    // Объявление холста
  ButtonGroup m_formauswahl;  // группа переключателей
  int m_Ypos, m_Xpos;  

  // В main() создается экземпляр класса
  // и выводится на дисплей
  public static void main(String[] args) {
    Freihand fenster = new Freihand("Рисуем произвольные линии");
    fenster.pack();
    fenster.setSize(450,350);
    fenster.setResizable(false);
    fenster.setVisible(true);
  }

  // В конструкторе Malflache создана  
  // группа переключателей ButtonGroup

  Freihand(String titel) {
    super(titel);

    // Менеджер компоновки
    setLayout(new FlowLayout());

    // Die Malflдche anlegen
    m_malflache = new MeineCanvas();
    add(m_malflache);

    // Panel-Container fьr Schaltflдchen anlegen
    JPanel panel = new JPanel();
      // Матрица из 3 строк и 1 столбца
      panel.setLayout(new GridLayout(4,1,20,20));     

      // Переключатели для выбора создаваемой фигуры
      m_formauswahl = new ButtonGroup();

      // 1. Генерация переключателей
      JRadioButton opt1 = new JRadioButton ("Окружность",false);
      JRadioButton opt2 = new JRadioButton ("Круг",false);
      JRadioButton opt3 = new JRadioButton ("Прямоугольник",false); 
      JRadioButton opt4 = new JRadioButton ("Карандаш",false); 

      // 2. Названия команд для переключателей
      opt1.setActionCommand("Окружность");
      opt2.setActionCommand("Круг");
      opt3.setActionCommand("Прямоугольник");
      opt4.setActionCommand("Карандаш");

      // 3. Переключатели в группе ButtonGroup
      m_formauswahl.add(opt1);
      m_formauswahl.add(opt2);
      m_formauswahl.add(opt3);
      m_formauswahl.add(opt4);

      // 4. Переключатели в панели
      panel.add(opt1);
      panel.add(opt2);
      panel.add(opt3);
      panel.add(opt4);
     
      add(panel); 
  
    // Fenster schlieЯen soll das ganze Programm beenden 
    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE); 
  }


  class MeineCanvas extends Canvas {
   // Адаптер класса закрыт для щелчков мыши.
   // Внутренний класс холста  
    class MeinMausAdapter extends MouseAdapter {
      public void mousePressed(MouseEvent e) {
        // Запоминание текущей позиции мыши
         m_Xpos = e.getX();
         m_Ypos = e.getY();

         // Перерисовка окна
         repaint();
      }
    }

    class MeinMausMotionAdapter extends MouseMotionAdapter {
      public void mouseDragged(MouseEvent e) {
        ButtonModel aktuell;
        String label;

        // Определяем, какая опция активна в данный момент
        aktuell = m_formauswahl.getSelection();

        // Так как после запуска программы нет выбранных опций,     
        // то должна производиться проверка.
        // При отсутствии выбранной опции возвращается нулевое значение.
        if(aktuell == null)
          return;

        label = aktuell.getActionCommand();

        // Только если выбрана функция рисования от руки,
        // фиксируется позиция мыши и происходит новое рисование
        if(label.equals("Карандаш"))  {
          Graphics tmp = m_malflache.getGraphics();
          m_Xpos = e.getX();
          m_Ypos = e.getY();
          tmp.drawOval(m_Xpos,m_Ypos,2,2);
        }
      }
    }
  
    // der Konstruktor implementiert die Mausbehandlung 
    // und setzt Hintergrund und Vordergrundfarbe
    MeineCanvas() {
      addMouseListener(new MeinMausAdapter());
      addMouseMotionListener(new MeinMausMotionAdapter());

      setBackground(Color.black);
      setForeground(Color.orange);
    }

    // Основной метод рисования
    public void paint(Graphics g) {
      String label;
      ButtonModel aktuell = null;

      // Какая фигура выбрана?
      aktuell = m_formauswahl.getSelection();

      // Действовать в соответствии с произведенным выбором
      if(aktuell == null)
        return;

      int w = (int) (Math.random()*300);
      int h = (int) (Math.random()*300);
      label = aktuell.getActionCommand();

      if(label.equals("Окружность"))
        g.drawOval(m_Xpos,m_Ypos,w,h);

      if(label.equals("Круг"))
        g.fillOval(m_Xpos,m_Ypos,w,h);

      if(label.equals("Прямоугольник"))
        g.drawRect(m_Xpos,m_Ypos,w,h);
    }  

    // Diese Methode liefert die minimale GrцЯe der anvas
    public Dimension getMinimumSize() {
      return new Dimension(300,300);
    }

    // Die LieblingsgrцЯe setzen wir auf die MinimalgrцЯe
    public Dimension getPreferredSize() {
      return getMinimumSize();
    }
  }  // Конец MeineCanvas

} // Конец Freihand 
