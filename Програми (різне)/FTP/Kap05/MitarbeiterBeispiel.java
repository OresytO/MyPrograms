class Mitarbeiter {
  String m_name;
  String m_vorname;
  int m_gehalt;       

  Mitarbeiter(String name, String vorname, int gehalt) {
    m_name = name;
    m_vorname = vorname;
    m_gehalt = gehalt;
  }

  void datenAusgeben() {
    System.out.println("\n");
    System.out.println(" Имя     : " + m_name);
    System.out.println(" Фамилия : " + m_vorname);
    System.out.println(" Зарплата: " + m_gehalt + " евро");
  }

  void gehaltErhoehen(int erhoehung) {
    m_gehalt += erhoehung;
  }
} 

// Производные классы. Класс стажера
class Lehrling extends Mitarbeiter {
  int abgelegtePruefungen;

  // Конструктор устанавливает количество пройденных испытаний равным 0
  Lehrling(String name, String vorname, int gehalt)  {
    // Вызов конструктора базового класса
    super(name, vorname, gehalt);

    // Инициализация собственных полей
    abgelegtePruefungen = 0;
  }
}

class Angestellter extends Mitarbeiter {
  int hierarchiestufe;
  final int MAX_HIERARHIE = 5;

  // Конструктор
  Angestellter(String name, String vorname, int gehalt) {
    // Вызов конструктора базового класса
    super(name,vorname,gehalt);

    // Инициализация собственных полей
    hierarchiestufe = 0;
  }

  void befoerdern() {
     // В случае возможности, повышение
     if(hierarchiestufe < MAX_HIERARHIE)
        hierarchiestufe++;
  }
}

class Chef extends Mitarbeiter {
  // Никаких расширений

  // Конструктор Chef вызывает только конструктор базового класса
  Chef(String name, String vorname,int gehalt)  {
    super(name,vorname,gehalt);
  }

  // Шеф получает зарплату больше
  void gehaltErhoehen(int erhoehung) {
    m_gehalt += 2*erhoehung;
  }
}


public class MitarbeiterBeispiel {
  public static void main(String[] args) {

    Mitarbeiter[] personalListe = new Mitarbeiter[3];

    personalListe[0] = new Chef("Граучо","Маркс",8000);
    personalListe[1] = new Angestellter("Чико","Маркс",4000);
    personalListe[2] = new Lehrling("Харпо","Маркс",1000);

    // Выходные данные
    for (int i = 0; i < personalListe.length; i++)
      personalListe[i].datenAusgeben();

    // Зарплата
    for (int i = 0; i < personalListe.length; i++)
      personalListe[i].gehaltErhoehen(1000);

    // Выходные данные
    for (int i = 0; i < personalListe.length; i++)
      personalListe[i].datenAusgeben();

  }
}

