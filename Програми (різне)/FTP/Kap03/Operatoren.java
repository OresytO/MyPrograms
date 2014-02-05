public class Operatoren {
  public static void main(String[] args)  {
    int x,y,z;
    int ergebnis_1,ergebnis_2;

    x = 1;
    y = 2;
    z = 3;

    ergebnis_1 = x + y * z;
    ergebnis_2 = (5 - 3) * z;
    System.out.println(ergebnis_1); 
    System.out.println(ergebnis_2);

    x = x + z; 
    System.out.println(x);
    x += z;
    System.out.println(x);
    x += 1;
    System.out.println(x);
    x++;
    System.out.println(x);
  }}

