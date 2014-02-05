import java.lang.Math;
  public class Kaninchen {
    public static void main(String[] args) {
      double pop = 2;
      System.out.println();
      for(int jahr = 1; jahr <= 10; jahr++) {
      pop = 2*Math.exp(Math.log(15)*jahr);
      System.out.println("Через " + jahr + " года (лет): "
                        + (long) pop + " зверей");
   }
  }}