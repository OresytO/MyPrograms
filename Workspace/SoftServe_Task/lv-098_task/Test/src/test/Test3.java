package test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Test3 {
    public static void main(String[] args) {
        MyList<Word1> words = new MyList<Word1>();
        MyList<SubWord1> subWords1 = new MyList<SubWord1>();
        MyList<SubWord1> subWords2 = new MyList<SubWord1>(Arrays.asList(new SubWord1("fir"), new SubWord1("st ")));
        List<SubWord1> subWords3 = new ArrayList<SubWord1>(Arrays.asList(new SubWord1("fir"), new SubWord1("st ")));
        System.out.println(subWords3);
        // subWords.add(new SubWord1("fir"));
        // subWords.add(new SubWord1("st "));
        // words.add(new Word1(subWords));
        //
        // subWords = new MyList<SubWord1>();
        // subWords.add(new SubWord1("sec"));
        // subWords.add(new SubWord1("ond "));
        // words.add(new Word1(subWords));
        //
        // subWords = new MyList<SubWord1>();
        // subWords.add(new SubWord1("thi"));
        // subWords.add(new SubWord1("rd "));
        // words.add(new Word1(subWords));
        //
        // subWords = new MyList<SubWord1>();
        // subWords.add(new SubWord1("four"));
        // subWords.add(new SubWord1("th."));
        // words.add(new Word1(subWords));
        //
        // Sentence1 sentence1 = new Sentence1(words);
        // System.out.println(sentence1);

    }

}

class Sentence1 {
    private MyList<Word1> word1s;

    public Sentence1(MyList<Word1> word1s) {
        this.word1s = word1s;
    }

    public MyList<Word1> getWord1s() {
        return word1s;
    }

    public void setWord1s(MyList<Word1> word1s) {
        this.word1s = word1s;
    }

    @Override
    public String toString() {
        String str = "Your text is: \"";
        for (Word1 word1 : word1s) {
            str += word1;
        }
        return str + "\"";
    }

}

class Word1 {
    private MyList<SubWord1> word;

    public Word1(MyList<SubWord1> word) {
        this.word = word;
    }

    public MyList<SubWord1> getWord() {
        return word;
    }

    public void setWord(MyList<SubWord1> word) {
        this.word = word;
    }

    @Override
    public String toString() {
        // String str = "";
        // for (SubWord1 subWord1 : word) {
        // str += subWord1;
        // }
        // return str;
        return word.toString();
    }

}

class SubWord1 {
    private String subWord;

    public SubWord1(String subWord) {
        this.subWord = subWord;
    }

    public String getSubWord() {
        return subWord;
    }

    public void setSubWord(String subWord) {
        this.subWord = subWord;
    }

    @Override
    public String toString() {
        return subWord;
    }

}

class MyList<T> extends ArrayList<T> {
    public MyList() {
        super();
    }

    public MyList(T... args) {
        super(Arrays.asList(args));

        // for (T arg : args) {
        // this.add(arg);
        // }
    }

    public MyList(List asList) {
        super(asList);
    }

    @Override
    public String toString() {
        String str = "";
        for (T temp : this) {
            str += this.toString();
        }
        return str;
    }

}