// Файл Mitarbeiter.class из главы 3 должен находиться
// в том же самом каталоге
public class MitarbeiterVerwaltung {
  public static void main(String[] args) {
    Mitarbeiter[] personalliste = new Mitarbeiter[4];
    int mitarbeiterzahl;
    personalliste[0] = new Mitarbeiter("Маркс","Граучо",8000);
    personalliste[1] = new Mitarbeiter("Маркс","Чико",7000);
    personalliste[2] = new Mitarbeiter("Маркс","Харпо",7000);
    personalliste[3] = new Mitarbeiter("Маркс","Зеппо",7000);
    mitarbeiterzahl = 4;
    // Вывод всех сотрудников
    for(int i = 0; i < personalliste.length; i++)
      personalliste[i].datenAusgeben();
  }
}
