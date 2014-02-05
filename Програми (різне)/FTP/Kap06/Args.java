public class Args {
  public static void main(String[] args) {
    System.console().printf("\n");

    for(int i = 0; i < args.length; i++)
      System.console().printf(" %s\n", args[i]);
    }
}
