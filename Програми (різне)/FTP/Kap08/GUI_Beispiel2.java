 // Первая программа GUI с обработкой события
 import java.awt.*;
 import java.awt.event.*;

 public class GUI_Beispiel2 extends Frame {
   // Определение собственных классов Adapter и Listener
   // как внутренних классов
   // класса GUI_GBeispiel2
   class MeinWindowLauscher extends WindowAdapter {
   public void windowClosing(WindowEvent e) {
     // Выход из программы
     System.exit(0);
   }
  }

  class MeinActionLauscher implements ActionListener {
    public void actionPerformed(ActionEvent e) {
      // одиночный звуковой сигнал
      java.awt.Toolkit.getDefaultToolkit().beep();
    }
  }

   // Конструктор размещает три кнопки
   GUI_Beispiel2(String titel) {
     super(titel);

     // Формирование кнопок
     Button hansel = new Button("Гензель");
     Button und = new Button("и");
     Button gretel = new Button("Гретель");

     
     // Установка Layout-менеджера для размещения кнопок в линейку
     setLayout(new FlowLayout());

     // Добавление кнопки к фрейму
     add(hansel);
     add(und);
     add(gretel);


     //Добавление прослушивателя событий для окна -  WindowListener
     addWindowListener(new MeinWindowLauscher());

     // Регистрация ActionListener для кнопки.
     // Каждый раз создается новый экземпляр. 
     // Однако, экземпляр можно использовать неоднократно.
     hansel.addActionListener(new MeinActionLauscher());
     und.addActionListener(new MeinActionLauscher());
     gretel.addActionListener(new MeinActionLauscher());
   }

   public static void main(String[] args) {
     // Объявление и создание экземпляра класса
     GUI_Beispiel2 fenster =
                new GUI_Beispiel2("GUI с обработкой событий");
     fenster.pack();
     fenster.setVisible(true);
   }
 }
