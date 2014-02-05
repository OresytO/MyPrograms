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
    System.out.println("Имя      : " + m_name);
    System.out.println("Фамилия  : " + m_vorname);
    System.out.println("Зарплата : " + m_gehalt + " евро");
  }

  void gehaltErhoehen(int erhoehung) {
    m_gehalt += erhoehung;
  }
}
public class MitarbeiterBeispiel {
  public static void main(String[] args) {
   // Создание двух новых экземпляров Mitarbeiter
    Mitarbeiter billy = new Mitarbeiter("Гейтс","Билл",3000);
    Mitarbeiter stevie = new Mitarbeiter("Аллен","Стив",3500);

    // Вывод данных
    billy.datenAusgeben();
    stevie.datenAusgeben();

    // Повышение заработной платы
    billy.gehaltErhoehen(500);

    // Контроль
    billy.datenAusgeben();
    stevie.datenAusgeben();
  }
}