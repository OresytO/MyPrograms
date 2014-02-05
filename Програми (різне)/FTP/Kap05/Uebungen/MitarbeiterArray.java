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
    System.out.println(" ���     : " + m_name);
    System.out.println(" ������� : " + m_vorname);
    System.out.println(" ��������: " + m_gehalt + " ����");
  }

  void gehaltErhoehen(int erhoehung) {
    m_gehalt += erhoehung;
  }
} 

// ����������� ������. ����� �������
class Lehrling extends Mitarbeiter {
  int abgelegtePruefungen;

  //����������� ������������� ���������� ���������� ��������� ������ 0
  Lehrling(String name, String vorname, int gehalt)  {
    // ����� ������������ �������� ������
    super(name, vorname, gehalt);

    // ������������� ����������� �����
    abgelegtePruefungen = 0;
  }
}

class Angestellter extends Mitarbeiter {
  int hierarchiestufe;
  final int MAX_HIERARHIE = 5;

  // �����������
  Angestellter(String name, String vorname, int gehalt) {
    // ����� ������������ �������� ������
    super(name,vorname,gehalt);

    // ������������� ����������� �����
    hierarchiestufe = 0;
  }

  void befoerdern() {
     // � ������ �����������, ���������
     if(hierarchiestufe < MAX_HIERARHIE)
        hierarchiestufe++;
  }
}

class Chef extends Mitarbeiter {
  // ������� ����������

  // ����������� Chef �������� ������ ����������� �������� ������
  Chef(String name, String vorname,int gehalt)  {
    super(name,vorname,gehalt);
  }

  // ��� �������� �������� ������
  void gehaltErhoehen(int erhoehung) {
    m_gehalt += 2*erhoehung;
  }
}


public class MitarbeiterArray {
  public static void main(String[] args) {
    Mitarbeiter[] personalListe = new Mitarbeiter[5];
 
    personalListe[0] = new Angestellter("�������","������",3000);  
    personalListe[1] = new Angestellter("����","��������",3000);  
    personalListe[2] = new Lehrling("����","������",700);  
    personalListe[3] = new Chef("���","���",7000);  
    personalListe[4] = new Angestellter("�����","��������",3500);  

    // ����� ���� ��������
    for(int i = 0; i < personalListe.length; i++)
      personalListe[i].datenAusgeben();
  }
}