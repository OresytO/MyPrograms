// Bildbetrachter
import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class Bildbetrachter3 extends JFrame {
  static Bildbetrachter3 m_fenster;
  String  m_dateiname;           // Имя файла
  Image   m_aktBild;             // Объект для отображения рисунка
  BildLeinwand m_bildanzeige;    // JPanel - окно приложения
  int m_Xpos,m_Ypos;             // позиция, в которой 
                                 // находится левый верхний 
                                 // угол изображения
  int m_bild_x1,m_bild_y1;       // текущие координаты 
  int m_bild_x2,m_bild_y2;       // изображения
  int m_bildHoehe,m_bildBreite;  // Высота и ширина в пикселах

  // Обработка события
  class MeinActionLauscher implements ActionListener {
    public void actionPerformed(ActionEvent e) {
      String Label;

      Label = e.getActionCommand();

      if(Label.equals("Закрыть"))
         System.exit(0);

      if(Label.equals("Загрузить изображение"))
         bildLaden();         
      }
    }

  // В конструкторе размещаются Panel (как область
  // для отображения рисунка) и линейка меню
  Bildbetrachter3(String titel) {
    super(titel);

    m_Xpos = m_Ypos = 0;       // Позиция запуска: слева вверху
    m_bild_x1 = m_bild_x2 = m_bild_y1 = m_bild_y2 = 0;

    // Вначале никакое изображение не загружено
    m_dateiname = null;
    m_aktBild = null;

    // Подключение Layout-менеджера
    setLayout(new FlowLayout());

    // Создание экрана (производится от JPanel)
    m_bildanzeige  = new BildLeinwand();
    add(m_bildanzeige);
  
    // Обеспечение окна линейкой меню
    JMenuBar menueleiste = new JMenuBar();
    setJMenuBar(menueleiste);

    // Создание всплывающего меню в линейке меню
    JMenu menu1 = new JMenu("Файл");
    JMenuItem item1  = new JMenuItem("Загрузить изображение");
    item1.addActionListener(new MeinActionLauscher());

    JMenuItem item2 = new JMenuItem("Закрыть");
    item2.addActionListener(new MeinActionLauscher());
    menu1.add(item1);
    menu1.add(item2);
    menueleiste.add(menu1);

    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
  }

  // Загрузка файла с изображением
  public void bildLaden(){
    FileDialog d = new FileDialog(this,"Загрузить изображение...",
                                  FileDialog.LOAD);
    d.setVisible(true);
    m_dateiname = d.getDirectory();
    m_dateiname += d.getFile();

    // Если пользователь не выбрал файл c рисунком,
    // то будет возвращен null.
    // Тогда никаких дальнейших действий не выполняем.
    if(m_dateiname == null)
       return;

    // Загрузка рисунка 
    ImageIcon tmp = new ImageIcon(m_dateiname);
    m_aktBild = tmp.getImage(); 

    // Получение высоты и ширины рисунка
    m_bildBreite = m_aktBild.getWidth(m_bildanzeige);
    m_bildHoehe = m_aktBild.getHeight(m_bildanzeige);

    m_bild_x1 = m_Xpos;
    m_bild_y1 = m_Ypos;
    m_bild_x2 = m_bild_x1 + m_bildBreite;
    m_bild_y2 = m_bild_y1 + m_bildHoehe;

    m_bildanzeige.repaint();
  }

  public static void main(String[] args) {
    m_fenster = new Bildbetrachter3("Просмотр и перетаскивание изображений");
    m_fenster.setSize(800,700);
    m_fenster.pack();
    m_fenster.setVisible(true);
  }


  // Этот класс служит для воспроизведения изображения
  class BildLeinwand extends JPanel {

    class MeinMausMotionAdapter extends MouseMotionAdapter {
      public void mouseDragged(MouseEvent e) {
        // Локальные переменные
        int x,y;
    
        // Если изображение не загружено, ничего не делаем
        if(m_aktBild == null)
          return;

        // Запрос координат мыши
        x = e.getX();
        y = e.getY();

        // Изменение координат изображения при перетаскивании
        if(   x >= m_bild_x1 && x <= m_bild_x2 
           && y >= m_bild_y1 && y <= m_bild_y2) {

           m_Xpos = x - m_bildBreite/2;
           m_Ypos = y - m_bildHoehe/2;

           // Расчет новых координат и перерисовка изображения
           m_bild_x1 = m_Xpos; 
           m_bild_y1 = m_Ypos;
           m_bild_x2 = m_bild_x1 + m_bildBreite;
           m_bild_y2 = m_bild_y1 + m_bildHoehe;
           repaint();
        }
      }
    } 

    BildLeinwand (){
      addMouseMotionListener(new MeinMausMotionAdapter());
    }
    
    // Рисование новой панели
    public void paintComponent(Graphics g) {
      super.paintComponent(g);

      // Если изображение загружено, то оно показывается
      if(m_aktBild != null)
        g.drawImage(m_aktBild,m_Xpos,m_Ypos,this);
    }

    public Dimension getMinimumSize() {
      return m_fenster.getSize();
    }
    public Dimension getPreferredSize() {
      return getMinimumSize();
    }
  }
}
