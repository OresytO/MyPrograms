package zinsrechnung;

public class Sparbuch {
  double kapital;
  double zinssatz;

  public Sparbuch(double kap, double zins)  {
    kapital = kap;
    zinssatz = zins;
  }

  public void einzahlen(double betrag)  {
    kapital += betrag;
  }

  public void abheben(double betrag)  {
    kapital -= betrag;
  }

  public double ertragZ(double laufzeit)  {
    return kapital*Math.pow((1 + zinssatz/100),laufzeit);
  }

  public double ertrag(double laufzeit)  {
    return kapital * (1+ zinssatz/100 * laufzeit);
  }
}
