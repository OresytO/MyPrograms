// Первая программа GUI с обработкой события
import java.awt.*;
import java.awt.event.*;

public class GUI_Beispiel4 extends Frame {
  Button m_hдnsel, m_und, m_gretel;

  // Определение собственных классов Adapter и Listener
  // как внутренних классов
  // класса GUI_GBeispiel4
  class MeinWindowLauscher extends WindowAdapter {
    public void windowClosing(WindowEvent e) {
      // Выход из программы
      System.exit(0);
    }
  }
 
class MeinMouseLauscher implements MouseListener{
   public void mouseClicked(MouseEvent e){
      // einmal piepen
      java.awt.Toolkit.getDefaultToolkit().beep();
   }
   public void mouseEntered(MouseEvent e) {
   }
   public void mouseExited(MouseEvent e) {
   }
   public void mousePressed(MouseEvent e) {
   }
   public void mouseReleased(MouseEvent e) {
   }
}

  // Конструктор размещает три кнопки
  GUI_Beispiel4(String titel) {
    super(titel);

    // Формирование кнопок
    m_hдnsel = new Button("Гензель");
    m_und  = new Button("и");
    m_gretel = new Button("Гретель");


    // Установка Layout-менеджера для размещения кнопок в линейку
    setLayout(new FlowLayout());

    // Добавление кнопки к фрейму
    add(m_hдnsel);
    add(m_und);
    add(m_gretel);

    // Добавление прослушивателя событий для окна -  WindowListener
    addWindowListener(new MeinWindowLauscher());

    // Регистрация ActionListener для кнопки.
    // Каждый раз создается новый экземпляр. 
    // Однако, экземпляр можно использовать неоднократно.
    m_hдnsel.addMouseListener(new MeinMouseLauscher());
    m_und.addMouseListener(new MeinMouseLauscher());
    m_gretel.addMouseListener(new MeinMouseLauscher());
  }

  public static void main(String[] args) {
    // Объявление и создание экземпляра класса
    GUI_Beispiel4 fenster = new GUI_Beispiel4("GUI с обработкой событий");
    fenster.pack();
    fenster.setVisible(true);   
  }
}
