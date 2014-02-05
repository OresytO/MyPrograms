// Ein Funktionenplotter
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

// Основное окно Swing-класса JFrame
public class FunkPlotter2 extends JFrame {
  MeineCanvas m_malflaeche;
  int aktFunktion = 0;  // эта переменная определяет
                        // используемую функцию;
                        // Начальное значение 0 - функция отсутствует

  public static void main(String[] args) {
    FunkPlotter2 fenster = new FunkPlotter2("График фукции");
    fenster.pack();
    fenster.setSize(450,350);
    fenster.setResizable(false);
    fenster.setVisible(true);
  }

  // В конструкторе будут созданы холст Canvas для рисования и
  // кнопки для выбора функций
  FunkPlotter2(String titel) {
    super(titel);

    // Организация Layout-менеджера
    setLayout(new FlowLayout());

    // Запись поверхности для рисования
    m_malflaeche = new MeineCanvas();
    add(m_malflaeche);
 
    // Создание Panel-контейнера для кнопок
    JPanel panel = new JPanel();
      // Матрица с 2 строками и 1 столбцом
      panel.setLayout(new GridLayout(2,1, 20, 20));     
  
      // Создание кнопок и добавление их на панель
      JButton f1 = new JButton("tan(x)");
      JButton f2 = new JButton("x^3");
      panel.add(f1);
      panel.add(f2);
  
    add(panel);

    // Обработчик событий для кнопки
    class MeinActionLauscher implements ActionListener {
      public void actionPerformed(ActionEvent e) {
        String label;

        label = e.getActionCommand();
       
        if(label.equals("tan(x)"))
            aktFunktion = 1;
        else
	      aktFunktion = 2;
         
        // Вызов перерисовки
        m_malflaeche.repaint();
      }
    }

    // Добавление к кнопкам прослушивателя событий
    f1.addActionListener(new MeinActionLauscher());
    f2.addActionListener(new MeinActionLauscher());

    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE); 
  }

  class MeineCanvas extends Canvas {
    // Конструктор
    MeineCanvas() {
      // Установка черного цвета фона
      setBackground(Color.black);

      // Установка зеленого цвета переднего плана (цвет линий)
      setForeground(Color.green);
    }

    // Самый важный метод, выполняющий рисование
    public void paint(Graphics g) {
      double x,y;
      int xpos,ypos;

      // Перемещение начала координат в точку (150,150)
      g.translate(150,150);
 
      // Рисование координатных осей белым цветом
      g.setColor(Color.white);
      g.drawLine(0,-150,0,150);
      g.drawLine(-150,0,150,0);
      g.drawString("-3",-150,12);
      g.drawString("-3",4,147);
      g.drawString("+3",135,12);
      g.drawString("+3",4,-140);

      // Желтый цвет линии для рисования функции
      g.setColor(new Color(255,255,0));
        
      // Если никакая функция не выбрана, ничего не выполняется
      if(aktFunktion == 0)
	  return;

      for(x= -3.0; x<=3; x += 0.005) {
        if(aktFunktion == 1)
          y = Math.tan(x);
        else
          y = Math.pow(x,3);

        xpos = (int) (x*50); 
        ypos = (int) (-y*50); 
       
        g.fillOval(xpos,ypos,3,3);
      }  
    }

    // Этот метод определяет минимальные размеры холста Canvas
    public Dimension getMinimumSize() {
      return new Dimension(300,300);
    }

    // Установка предпочтительных размеров холста
    public Dimension getPreferredSize() {
      return getMinimumSize();
    }
  }

} // Конец класса FunkPlotter
