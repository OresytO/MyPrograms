package org.Lists;

import java.util.List;

public class Word {
    private List<SubWord> word;

    public Word() {
    }

    public Word(List<SubWord> word) {
        super();
        this.word = word;
    }

    public Word(SubWord... word) {
        this.word = new MyListExt<SubWord>(word);
    }

    @Override
    public String toString() {
        return word.toString();
    }

}
