// ���� Mitarbeiter.class �� ����� 3 ������ ����������
// � ��� �� ����� ��������
public class MitarbeiterVerwaltung {
  public static void main(String[] args) {
    Mitarbeiter[] personalliste = new Mitarbeiter[4];
    int mitarbeiterzahl;
    personalliste[0] = new Mitarbeiter("�����","������",8000);
    personalliste[1] = new Mitarbeiter("�����","����",7000);
    personalliste[2] = new Mitarbeiter("�����","�����",7000);
    personalliste[3] = new Mitarbeiter("�����","�����",7000);
    mitarbeiterzahl = 4;
    // ����� ���� �����������
    for(int i = 0; i < personalliste.length; i++)
      personalliste[i].datenAusgeben();
  }
}
