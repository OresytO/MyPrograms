package org.Lists;

import java.util.List;

public class Sentence {
    private List<Word> sentence;

    public Sentence() {
    }

    public Sentence(List<Word> sentence) {
        super();
        this.sentence = sentence;
    }

    public Sentence(Word... sentence) {
        this.sentence = new MyListImpl<Word>(sentence);
    }

    @Override
    public String toString() {
        return sentence.toString();
    }

}
