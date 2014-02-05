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
       System.err.println(" JDBC/ODBC-драйвер не может быть загружен.");
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
       System.err.println(" Подключение к " + URL 
                          + " не может быть установлено");
       return;
    }

    // Считывание данных
    try {
       ResultSet datenmenge;
       datenmenge = befehl.executeQuery("SELECT * FROM Федеральные_земли ORDER BY [Название земли];");

       // Вывод заголовка
       Console cons = System.console();
       cons.printf("\n");
       cons.printf("  Федеральная земля \t\t   Население (млн чел.) \n");
       cons.printf("\n");

       // Вывод отдельных полей данных
       String land;
       int    einw;

       while(datenmenge.next())  {
         land = datenmenge.getString("Название земли");
         einw = datenmenge.getInt("Население");
           cons.printf("  %-31s \t %d \n", land, einw);
       }
  
       verbindung.close();
    }
    catch (Exception e) {
       e.printStackTrace();
    }
  }
}
