package test;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

public class TestEncoding {

    public static void main(String[] args) throws UnsupportedEncodingException {
        String str = "M\u00C9XICO D.F.";
        System.out.println(str);
        str = URLDecoder.decode(str, "UTF-8");
        System.out.println(str);
        str = URLEncoder.encode(str, "UTF-8");
        System.out.println(str);

    }

}
