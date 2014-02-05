import java.awt.*;

public class GUI_Beispiel extends Frame{
  // конструктор размещает три кнопки
  GUI_Beispiel(String titel) {
    super(titel);	// Заголовок окна
    // Формирование кнопок
    Button hansel = new Button("Гензель");
    Button und	= new Button("и");
    Button gretel = new Button("Гретель");

    // Установка Layout-менеджера для размещения кнопок
    setLayout(new FlowLayout());

    // Добавление кнопок в окно
    add(hansel);
    add(und);
    add(gretel);
  }

  public static void main(String[] args) {
    // создание экземпляра оконного класса
    GUI_Beispiel fenster =
      new GUI_Beispiel("Первая GUI-программа");

    fenster.pack();
    fenster.setVisible(true);
  }
}
