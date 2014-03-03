package org;

class A {
    public String pu = "pu";
    public static String pus = "pus";
    public static final String pusf = "pusf";

    private String pr = "pr";
    private static String prs = "prs";
    private static final String prsf = "prsf";

    public A(String pr, String prs) {
        this.pr = pr;
        this.prs = prs;
    }

    @Override
    public String toString() {
        return "[" + pu + ",\t" + pus + ",\t" + pusf + ",\t" + pr + ",\t" + prs + ",\t" + prsf + "]";
    }

    public int meth1() {
        try {
            return 1;
        } finally {
            return 10;
        }
    }

    public int meth2() {
        try {
            return 5;
        } finally {
            System.out.println(100);
        }
    }
}

class B1 extends A {

    public String pu = "pu1";
    public static String pus = "pus1";
    public static final String pusf = "pusf1";

    private String pr = "pr1";
    private static String prs = "prs1";
    private static final String prsf = "prsf1";

    public B1(String pr, String prs) {
        super(pr, prs);
        this.pr = pr;
        this.prs = prs;
    }

    @Override
    public String toString() {
        return "[" + pu + ",\t" + pus + ",\t" + pusf + ",\t" + pr + ",\t" + prs + ",\t" + prsf + "]";
    }

    public void meth() {
        System.out.println("class B1");
        prs = prs + "10";
    }
}

class B2 extends A {

    public B2(String pr, String prs) {
        super(pr, prs);
    }

    public void meth() {
        System.out.println("class B2");
    }
}

public class Test {
    static void meth(Object str) {
        System.out.println(str);
    }

    public static void main(String[] args) {

        String str = "1";
        A a = new A("1", str);
        System.out.println(a.meth1());
        System.out.println(a.meth2());
        // System.out.println(a);
        // System.out.println(str);
        // System.out.println();
        //
        // B1 b1 = new B1("3", str);
        // System.out.println(a);
        // System.out.println(b1);
        // System.out.println(str);
        // System.out.println();
        //
        // B2 b2 = new B2("5", str);
        // System.out.println(a);
        // System.out.println(b1);
        // System.out.println(b2);
        // System.out.println(str);
        // System.out.println();
        //
        // a.meth();
        // System.out.println(a);
        // System.out.println(str);
        // System.out.println();
        //
        // b1.meth();
        // System.out.println(a);
        // System.out.println(b1);
        // System.out.println(str);
        // System.out.println();
        //
        // b2.meth();
        // System.out.println(a);
        // System.out.println(b1);
        // System.out.println(b2);
        // System.out.println(str);
        // System.out.println();
        //
        // System.out.println(a);
        // System.out.println(b1);
        // System.out.println(b2);

    }
}
