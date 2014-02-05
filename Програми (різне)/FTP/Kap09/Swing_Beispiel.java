 // Установка Swing-пакета
 import javax.swing.*;
 import java.awt.*;
 import java.awt.event.*;

 // Определение класса окна
 public class Swing_Beispiel extends JFrame {
   JButton m_hansel, m_und, m_gretel;


   // Обработка событий для элементов управления
   class MeinActionLauscher implements ActionListener {
     public void actionPerformed(ActionEvent e) {
       int i;

       m_hansel.setText("заблудились");
       m_und.setText("они");
       m_gretel.setText("в лесу");
     }
   }

   // Конструктор
   Swing_Beispiel(String titel) {
     super(titel);

   // Формирование кнопок
     m_hansel = new JButton("Гензель");
     m_und	= new JButton("и");
     m_gretel = new JButton("Гретель");

     // Layout-менеджер для расположения кнопок
     setLayout(new FlowLayout());

     // Добавление кнопок в окно
     add(m_hansel);
     add(m_und);
     add(m_gretel);


     // Приложение заканчивается, если окно закрывается
     setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);

     // добавление прослушивателя событий ActionListener для кнопок
     m_hansel.addActionListener(new MeinActionLauscher());
     m_und.addActionListener(new MeinActionLauscher());
     m_gretel.addActionListener(new MeinActionLauscher());
   }


   public static void main(String[] args) {
     Swing_Beispiel fenster = new Swing_Beispiel("Swing");
     fenster.pack();
     fenster.setSize(300,100);
     fenster.setVisible(true);
   }
 }
