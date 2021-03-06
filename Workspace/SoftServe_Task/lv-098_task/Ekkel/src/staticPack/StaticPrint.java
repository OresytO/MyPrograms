package staticPack;

/**
 * 
 */

/**
 * @author orecto
 * 
 */
public class StaticPrint {
	public static void print(String str) {
		if (str == null)
			System.out.println("");
		else
			System.out.println(str);
	}

	public static void print(int i) {
		System.out.println(i);
	}

	public static void print(Object obj) {
		if (obj == null)
			System.err.println("obj => null");
		System.out.println(obj.toString());
	}

	public static void print(char ch) {
		System.out.println(ch);
	}

	public static void print() {
		System.out.println("");
	}
}
