// Файл AWT_zu_Swing2.java
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
// Определение класса окна
public class AWT_zu_Swing2 extends JFrame {
   JButton schalter;

  // Обработка событий от элементов управления
  class MeinActionLauscher implements ActionListener {
    public void actionPerformed(ActionEvent e) {
      schalter.setText("Спасибо");
    }
  }

  // Конструктор
  AWT_zu_Swing2(String titel) {
    super(titel);

    // Создание кнопок
    schalter = new JButton("Нажми меня");

    // Добавление кнопки в окно
    add(schalter);

    // Закрытие окна - закрытие приложения
    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);

    // Добавление прослушивателя ActionListener для кнопки
    schalter.addActionListener(new MeinActionLauscher());
  }
  public static void main(String[] args) {
    AWT_zu_Swing2 fenster = new AWT_zu_Swing2("Swing");
    fenster.pack();
    fenster.setSize(300,100);
    fenster.setVisible(true);
  }
}
