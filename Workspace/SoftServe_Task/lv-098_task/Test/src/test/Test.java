package test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Test {
    public static void main(String[] args) {
        Sentence sentence = new Sentence(Arrays.asList(new Word(Arrays.asList(new SubWord("fir"), new SubWord("st "))),
                new Word(Arrays.asList(new SubWord("sec"), new SubWord("ond "))), new Word(Arrays.asList(new SubWord("thi"), new SubWord("rd "))), new Word(
                        Arrays.asList(new SubWord("four"), new SubWord("th.")))));
        System.out.println(sentence);
    }
}

class Sentence {
    private List<Word> words;

    public Sentence(List<Word> words) {
        this.words = words;
    }

    @Override
    public String toString() {
        String str = "Your text is: \"";
        for (Word word : words) {
            str += word;
        }
        return str + "\"";
    }

}

class Word {
    private List<SubWord> word;

    public Word(List<SubWord> word) {
        this.word = word;
    }

    @Override
    public String toString() {
        String str = "";
        for (SubWord subWord : word) {
            str += subWord;
        }
        return str;
    }

}

class SubWord {
    private String subWord;

    public SubWord(String subWord) {
        this.subWord = subWord;
    }

    public String getSubWord() {
        return subWord;
    }

    @Override
    public String toString() {
        return subWord;
    }

}

class MyList<T> extends ArrayList<T> {

    @Override
    public String toString() {
        return this.toString();
    }


    
}
