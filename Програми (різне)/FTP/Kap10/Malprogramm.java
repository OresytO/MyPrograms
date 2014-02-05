// Malprogramm
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Malprogramm extends JFrame {
  MeineCanvas m_malflache;     // Объявление холста
  ButtonGroup m_formauswahl;   // группа переключателей
  int m_Xpos, m_Ypos;          // текущая позиция курсора мыши

  // В main() создается экземпляр класса
  // и выводится на дисплей
  public static void main(String[] args) {
    Malprogramm fenster = new Malprogramm("Рисуем геометрические фигуры");
    fenster.pack();
    fenster.setSize(450,350);
    fenster.setResizable(false);
    fenster.setVisible(true);
  }

  // В конструкторе Malflache
  // создана группа ButtonGroup
  // с доступными фигурами рисования
  Malprogramm(String titel) {
    super(titel);

    // Менеджер компоновки
    setLayout(new FlowLayout());

    // Die Malflдche anlegen
    m_malflache = new MeineCanvas();
    add(m_malflache);

  // Размещение Panel-контейнера для кнопок
  JPanel panel = new JPanel();
    // Матрица с 3 строками и 1 столбцом
    panel.setLayout(new GridLayout(3,1,20,20));

    // Переключатели для выбора фигур
    m_formauswahl = new ButtonGroup();

    // 1. Генерация переключателей
    JRadioButton opt1 = new JRadioButton("Окружность",false);
    JRadioButton opt2 = new JRadioButton("Круг",false);
    JRadioButton opt3 = new JRadioButton("Прямоугольник",false);

    // 2. Названия команд для переключателей
    opt1.setActionCommand("Окружность");
    opt2.setActionCommand("Круг");
    opt3.setActionCommand("Прямоугольник");

    // 3. Переключатели в группе ButtonGroup
    m_formauswahl.add(opt1);
    m_formauswahl.add(opt2);
    m_formauswahl.add(opt3);

    // 4. Переключатели в панели
    panel.add(opt1);
    panel.add(opt2);
    panel.add(opt3);
     
    add(panel);
    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);   
  }


  class MeineCanvas extends Canvas {
    // Адаптер класса закрыт для щелчков мыши 
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

    // der Konstruktor implementiert die Mausbehandlung 
    // und setzt Hintergrund und Vordergrundfarbe
    MeineCanvas() {
      addMouseListener(new MeinMausAdapter());

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
        g.drawOval(m_Xpos,m_Ypos,w,w);

      if(label.equals("Круг"))
        g.fillOval(m_Xpos,m_Ypos,w,h);

      if(label.equals("Прямоугольник"))
        g.drawRect(m_Xpos,m_Ypos,w,h);
    }

    // 
    public Dimension getMinimumSize() {
      return new Dimension(300,300);
    }

    // Die LieblingsgrцЯe setzen wir auf die MinimalgrцЯe
    public Dimension getPreferredSize() {
      return getMinimumSize();
    }
  }  // Конец MeineCanvas 

} // Конец Malprogramm 
