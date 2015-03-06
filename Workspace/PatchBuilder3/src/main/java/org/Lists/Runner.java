package org.Lists;

import java.util.List;

public class Runner
{
  public static void main(String[] args)
  {
    List<Word> words;
    Sentence sentence;

    words = new MyListImpl<>(new Word(new MyListImpl<>(new SubWord("fir"), new SubWord("st "))), new Word(new MyListImpl<>(new SubWord("sec"), new SubWord("ond "))));
    System.out.println("MyListImpl :" + words);

    words = new MyListImpl<>(new Word(new SubWord("fir"), new SubWord("st ")), new Word(new SubWord("sec"), new SubWord("ond ")));
    System.out.println("MyListImpl :" + words);

    sentence = new Sentence(new Word(new SubWord("fir"), new SubWord("st ")), new Word(new SubWord("sec"), new SubWord("ond ")));
    System.out.println("sentence :" + sentence);

    /*------------------------------------------------------------------------*/
    System.out.println("------------------------------------------------------------------------");
    /*------------------------------------------------------------------------*/

    words = new MyListExt<>(new Word(new MyListExt<>(new SubWord("fir"), new SubWord("st "))), new Word(new MyListExt<>(new SubWord("sec"), new SubWord("ond "))));
    System.out.println("MyListExt :" + words);

    words = new MyListExt<>(new Word(new SubWord("fir"), new SubWord("st ")), new Word(new SubWord("sec"), new SubWord("ond ")));
    System.out.println("MyListExt :" + words);

    sentence = new Sentence(new Word(new SubWord("fir"), new SubWord("st ")), new Word(new SubWord("sec"), new SubWord("ond ")));
    System.out.println("sentence :" + sentence);

  }
}
