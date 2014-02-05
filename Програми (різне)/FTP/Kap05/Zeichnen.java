// Базовый класс
abstract class Figur {
  int m_xKoord, m_yKoord;  //x-, y-координаты фигур

  Figur(int x, int y) {
    m_xKoord = x;
    m_yKoord = y;
  }

  abstract void zeichnen();
}

// Производный класс
class Kreis extends Figur {
  int m_radius;

  Kreis(int x, int y, int r) {
    super(x,y);
    m_radius = r;
  }
    
  void zeichnen() {
    System.out.println(" Метод рисования кругов");
  }
}

// Производный класс
class Rechteck extends Figur {
  int m_breite, m_laenge;

  Rechteck(int x, int y, int l, int b) {
    super(x,y);
    m_laenge = l;
    m_breite = b;
  }
 
  void zeichnen() {
    System.out.println(" Метод рисования прямоугольников");
  }
}

// Производный класс
class Linie extends Figur {
  int m_endpX, m_endpY;

  Linie(int ax, int ay, int ex, int ey) {
    super(ax,ay);
    m_endpX = ex;
    m_endpY = ey;
    }

  void zeichnen() {
    System.out.println(" Метод рисования линий");
  }
}

public class Zeichnen {
  static Figur[] zeichenobjekte = new Figur[5];

  public static void main(String[] args) {
    System.out.println();
    
    zeichenobjekte[0] = new Kreis(20,30,10);
    zeichenobjekte[1] = new Rechteck(2,78,50,50);
    zeichenobjekte[2] = new Kreis(99,30,10);
    zeichenobjekte[3] = new Linie(201,44,201,66);
    zeichenobjekte[4] = new Linie(10,50,50,50);
 
    for(int loop=0;loop<zeichenobjekte.length;loop++) 
      zeichenobjekte[loop].zeichnen();
  }
}    

