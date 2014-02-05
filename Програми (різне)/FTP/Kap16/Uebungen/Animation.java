// Image-анимация
import java.applet.*;
import java.awt.*;
import java.net.*;

 public class Animation extends Applet 
                         implements Runnable {
   Image m_bilder[] = new Image[2];
   String m_bildDateien[] = {"T1.gif", "T2.gif"};
   Image m_aktBild;
   Thread m_animator;
   int m_x, m_y;

   public void init()  {
     MediaTracker ladeKontrolle = new MediaTracker(this);

    for(int i = 0; i < 2; i++) {
      // Загрузка и регистрация изображения при MediaTracker
      URL codebase = getCodeBase();
      m_bilder[i] = getImage(codebase, m_bildDateien[i]);   
      ladeKontrolle.addImage(m_bilder[i],0);
  
      // Ожидание до полной загрузки изображения
      try {
        ladeKontrolle.waitForID(0);
      }
      catch(InterruptedException e) {
        // Загрузка не удалась
        m_bilder[i] = null;
        return;
      }
    }
    m_aktBild = m_bilder[0];
  }

   public void start() {
     m_x = 0; 
     m_y = 0;

     // Создание и запуск потока
     m_animator = new Thread(this);  
     m_animator.start();              
   }

   public void paint(Graphics g)  {
     g.drawImage(m_aktBild,m_x,m_y,this);
   }

   public void run()  {
     while(m_x <= getSize().width + 10)  {
       if(m_aktBild == m_bilder[0])
          m_aktBild = m_bilder[1];
       else
          m_aktBild = m_bilder[0];

       repaint();
       m_x += 10;
       try  {
          m_animator.sleep(500);
       }
       catch(InterruptedException e)  {
          return;
       }
     }
     m_animator = null;
   }
 } // Конец
