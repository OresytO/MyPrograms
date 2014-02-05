// Файл AWT_zu_Swing1.java
import java.awt.*;
import java.awt.event.*;

// Определение класса окна
public class AWT_zu_Swing1 extends Frame {
  Button schalter;

  // Задание обработки события для окна
  class MeinWindowLauscher extends WindowAdapter {
    public void windowClosing(WindowEvent e) {
      System.exit(0);
    }
  }
  // Обработка событий для элементов управления
  class MeinActionLauscher implements ActionListener {
    public void actionPerformed(ActionEvent e) {
      schalter.setLabel("Спасибо");
    }
  }

  // Конструктор
  AWT_zu_Swing1(String titel) {
    super(titel);

    // Формирование кнопок
    schalter = new Button("Нажми меня");

    // Задание кнопки в окне
    add(schalter);
    // Закрытие окна - закрытие приложения
    addWindowListener(new MeinWindowLauscher());

    // Регистрация кнопки с ActionListener
    schalter.addActionListener(new MeinActionLauscher());
  }

  public static void main(String[] args) {
    AWT_zu_Swing1 fenster = new AWT_zu_Swing1("AWT");
    fenster.pack();
    fenster.setSize(300,100);
    fenster.setVisible(true);
  }
}
