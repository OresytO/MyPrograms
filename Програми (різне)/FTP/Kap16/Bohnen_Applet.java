// Танцующие бабы
import java.awt.*;
import java.net.*;
import java.applet.*;
import java.awt.event.*;

public class Bohnen_Applet extends Applet
                            implements Runnable {
  Thread       m_bohne;
  AudioClip    m_klang;      // Фоновая музыка
  MediaTracker m_tracker;    // Контролируемая загрузка изображения
  Image[]      m_bilderfeld = new Image[11];   // Изображения
  int          m_aktBild ;  // Индекс изображения, которое
                            // должно показываться
  int m_bildHцhe;       
  int m_bildBreite;


  public void init() {
    URL Codebase;

    // Светло-серый цвет фона
    setBackground(Color.lightGray);

    Codebase = getCodeBase();
    m_tracker = new MediaTracker(this);

    // Загрузка звукового файла
    m_klang = getAudioClip(Codebase,"spacemusic.au");

    // Загрузка отдельных кадров, которые служат
    // для мультипликации бобов; сохраняются в массиве

    for(int i=1; i<= 10; i++)  {
      m_bilderfeld[i]= getImage(Codebase,"T"+i+".gif");

      // Добавление всех изображений в MediaTracker
      m_tracker.addImage(m_bilderfeld[i],1);
    }

    // Завершение загрузки
    try  {
       m_tracker.waitForAll();
       m_aktBild = 1;
    }
    catch(InterruptedException e) {
       return;
    }
  }
  

  public void start() {
    // Запуск потока
    if(m_bohne == null) {
      m_bohne = new Thread(this);
      m_bohne.start();

      // Воспроизведение звука в бесконечном цикле
      if(m_klang != null)
         m_klang.loop();
    }
  }

  public void stop() {
    // Окончание потока
    if(m_bohne != null) {
      m_bohne = null;
    }

    // Остановка воспроизведения звука
    if(m_klang != null)
        m_klang.stop();
  }

  public void destroy() {
    // Окончание потока
    if(m_bohne != null) {
      m_bohne = null;
    }

    // Остановка воспроизведения звука
    if(m_klang != null)
        m_klang.stop();
  }

  // Метод run() потока находится внутри апплета!
  public void run()  {
    while(m_bohne == Thread.currentThread())  {
      // Получаем размеры старого изображения, чтобы в paint()
      // была возможность удаления соответствующей части
      m_bildBreite = m_bilderfeld[m_aktBild].getWidth(this);
      m_bildHцhe =   m_bilderfeld[m_aktBild].getHeight(this);

      m_aktBild++;       // Замена изображения
      if(m_aktBild > 10)
        m_aktBild = 1;

      repaint();         // ... и показ
      try {
        m_bohne.sleep(200);
        if(m_aktBild == 10)
           m_bohne.sleep(500);
      }
      catch(InterruptedException e)  {
        return;
      }                                                                            
    }
  }

  // Перезапись update(), чтобы не было никаких
  // излишних удалений перед вызовом paint()
  public void update(Graphics g) {
    paint(g);
  }

  // Здесь показывается картинка
  public void paint(Graphics g) {
    // Если изображение не загружено, то никаких действий
    if(!m_tracker.checkAll())
        return;

    // Удаление последнего изображения
    g.setColor(Color.lightGray);
    g.fillRect(0,0,m_bildBreite,m_bildHцhe);

    // Показ нового изображения
    g.drawImage(m_bilderfeld[m_aktBild], 0, 0,this);
  }
} // Конец класса Bohnen_Applet 
