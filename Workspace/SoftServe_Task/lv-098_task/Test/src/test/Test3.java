package test;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

public class Test3 {

    public static void main(String[] args) {

        Map<String, Email> map = new LinkedHashMap<>();
        System.out.println(map.put("Orest", new Email("Orest", "1")));
        System.out.println(map.put("Orest", new Email("Orest", "2")));
        System.out.println(map.put("Orest", new Email("Orest", "3")));
        System.out.println(map.put("Orest1", new Email("Orest", "1")));
        System.out.println(map.put("Orest1", new Email("Orest", "2")));
        System.out.println(map.put("Orest1", new Email("Orest", "3")));

        System.out.println(map);

        for (String key : map.keySet()) {
            System.out.println(map.get(key));
        }

    }

    public Collection<Collection<Email>> batchEmails(Collection<Email> emails) {

        return null;
    }

}

class Email {
    private String to;
    private String message;

    public Email(String to, String message) {
        this.to = to;
        this.message = message;
    }

    @Override
    public int hashCode() {
        return this.to.hashCode();
    }

    @Override
    public boolean equals(Object obj) {
        return this.to.equals(obj);
    }

    @Override
    public String toString() {
        return "Email [to=" + to + ", message=" + message + "]";
    }

}