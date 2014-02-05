 // Первая программа GUI с обработкой события
 import java.awt.*;
 import java.awt.event.*;

public class GUI_Beispiel3 extends Frame {
  Button m_hansel, m_und, m_gretel;

   // Определение собственных классов Adapter и Listener
   // как внутренних классов
   // класса GUI_GBeispiel3
   class MeinWindowLauscher extends WindowAdapter {
   public void windowClosing(WindowEvent e) {
     // Выход из программы
     System.exit(0);
   }
  }

  class MeinActionLauscher implements ActionListener{
    public void actionPerformed(ActionEvent e){
      // Изменение заголовка
      m_hansel.setLabel("заблудились");
      m_und.setLabel("в");
      m_gretel.setLabel("лесу");
    }
  }

   // Конструктор размещает три кнопки
   GUI_Beispiel3(String titel) {
     super(titel);

     // Формирование кнопок
     m_hansel = new Button("Гензель");
     m_und    = new Button("и");
     m_gretel = new Button("Гретель");
   
     // Установка Layout-менеджера для размещения кнопок в линейку
     setLayout(new FlowLayout());

     // Добавление кнопки к фрейму
     add(m_hansel);
     add(m_und);
     add(m_gretel);


     // Добавление прослушивателя событий для окна -  WindowListener
     addWindowListener(new MeinWindowLauscher());

     // Регистрация ActionListener для кнопки.
     // Каждый раз создается новый экземпляр. 
     // Однако, экземпляр можно использовать неоднократно.
     m_hansel.addActionListener(new MeinActionLauscher());
     m_und.addActionListener(new MeinActionLauscher());
     m_gretel.addActionListener(new MeinActionLauscher());

   }

   public static void main(String[] args) {
     // Объявление и создание экземпляра класса
     GUI_Beispiel3 fenster =
                new GUI_Beispiel3("GUI с обработкой событий");
     fenster.pack();
     fenster.setVisible(true);
   }
 }
