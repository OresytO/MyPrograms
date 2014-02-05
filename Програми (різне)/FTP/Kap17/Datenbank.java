//Java-Anwendung mit Datenbankzugriff
import java.sql.*;
import java.io.*;

public class Datenbank {
  public static void main (String args[])  {
    String URL          = "jdbc:odbc:Lands";
    String benutzername = "Mickey";
    String passwort     = "Mouse";

    // Treiber laden 
    try  {
       Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
    } 
    catch (Exception e)  {
       System.err.println(" JDBC/ODBC-������� �� ����� ���� ��������.");
       return;
    }

    // Verbindung zu Datenbank aufbauen
    Statement  befehl     = null;
    Connection verbindung = null;
    try  {
       verbindung = DriverManager.getConnection (
                      URL,
                      benutzername,
                      passwort);
       befehl = verbindung.createStatement();
    } 
    catch (Exception e)  {
       System.err.println(" ����������� � " + URL 
                          + " �� ����� ���� �����������");
       return;
    }

    // ���������� ������
    try {
       ResultSet datenmenge;
       datenmenge = befehl.executeQuery("SELECT * FROM �����������_����� ORDER BY [�������� �����];");

       // ����� ���������
       Console cons = System.console();
       cons.printf("\n");
       cons.printf("  ����������� ����� \t\t   ��������� (��� ���.) \n");
       cons.printf("\n");

       // ����� ��������� ����� ������
       String land;
       int    einw;

       while(datenmenge.next())  {
         land = datenmenge.getString("�������� �����");
         einw = datenmenge.getInt("���������");
           cons.printf("  %-31s \t %d \n", land, einw);
       }
  
       verbindung.close();
    }
    catch (Exception e) {
       e.printStackTrace();
    }
  }
}
